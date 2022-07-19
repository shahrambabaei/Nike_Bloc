import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/data/repo/comment_repository.dart';
import 'package:nike/ui/product/comment/bloc/comment_list_bloc.dart';
import 'package:nike/widgets/apperrorwidget.dart';
import 'package:nike/widgets/comment_list/comment_list_item.dart';

class CommentList extends StatelessWidget {
  const CommentList({Key? key, required this.productId}) : super(key: key);
  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentListBloc>(
      create: (context) {
        final CommentListBloc bloc = CommentListBloc(
            commentrepository: commentRepository, productId: productId);
        bloc.add(CommentListStarted());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
        builder: (context, state) {
          if (state is CommentListSuccess) {
            return SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: state.comments.length, (context, index) {
              return CommentListItem(commentEntinty: state.comments[index]);
            }));
          } else if (state is CommentListLoading) {
            return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is CommentListError) {
            return SliverToBoxAdapter(
                child: AppErrorwidget(
              exception: state.exception,
              onClick: () {
                BlocProvider.of<CommentListBloc>(context)
                    .add(CommentListStarted());
              },
            ));
          } else {
            throw Exception('state is not supported');
          }
        },
      ),
    );
  }
}
