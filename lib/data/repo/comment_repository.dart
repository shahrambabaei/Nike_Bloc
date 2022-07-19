import 'package:nike/configs/http_client.dart';
import 'package:nike/data/models/comment.dart';
import 'package:nike/data/source/comment_datasource.dart';


final commentRepository=CommentRepository(dataSource: CommentRemoteDataSource(httpClient));
abstract class ICommentRepository {
  Future<List<CommentEntinty>> getAll({required int productId});
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository({required this.dataSource});
  @override
  Future<List<CommentEntinty>> getAll({required int productId}) => dataSource.getAll(productId: productId);
}
