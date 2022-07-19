import 'package:dio/dio.dart';
import 'package:nike/configs/http_respose_validatore.dart';
import 'package:nike/data/models/comment.dart';

abstract class ICommentDataSource {
  Future<List<CommentEntinty>> getAll({required int productId});
}

class CommentRemoteDataSource with HttpResponseValidatore implements ICommentDataSource {
  final Dio httpClient;

  CommentRemoteDataSource(this.httpClient);
  @override
  Future<List<CommentEntinty>> getAll({required int productId}) async {
    final response = await httpClient.get('comment/list?product_id=$productId');
    validateResponse(response);
    final List<CommentEntinty> comments=[];
    (response.data as List).forEach((item) { 
      comments.add(CommentEntinty.fromJson(item));

    });
    return comments;

  }
}
