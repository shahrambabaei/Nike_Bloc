import 'package:dio/dio.dart';
import 'package:nike/configs/exceptions.dart';
import 'package:nike/configs/http_respose_validatore.dart';
import 'package:nike/data/models/banner.dart';
import 'package:nike/data/models/product.dart';
import 'package:nike/data/repo/banner_repository.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class BannerRemoteDataSource with HttpResponseValidatore implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);
  @override
  Future<List<BannerEntity>> getAll() async {
    final response = await httpClient.get('banner/slider');
    final banners = <BannerEntity>[];
    validateResponse(response);
    (response.data as List).forEach((element) {
      banners.add(BannerEntity.formJson(element));
    });
    return banners;
  }

}
