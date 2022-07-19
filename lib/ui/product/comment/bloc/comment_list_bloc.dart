
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/configs/exceptions.dart';
import 'package:nike/data/models/comment.dart';
import 'package:nike/data/repo/comment_repository.dart';

part 'comment_list_event.dart';
part 'comment_list_state.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final ICommentRepository commentrepository;
  final int productId;
  CommentListBloc({required this.commentrepository, required this.productId})
      : super(CommentListLoading()) {
    on<CommentListEvent>((event, emit) async {
      if (event is CommentListStarted) {
        emit(CommentListLoading());
        try {
          final comments = await commentrepository.getAll(productId: productId);
          emit(CommentListSuccess(comments: comments));
        } catch (e) {
          emit(CommentListError(
              exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
