import 'package:dio/dio.dart';
import 'package:nike/configs/http_respose_validatore.dart';
import 'package:nike/data/models/banner.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class BannerRemoteDataSource
    with HttpResponseValidatore
    implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);
  @override
  Future<List<BannerEntity>> getAll() async {
    final response = await httpClient.get('banner/slider');
    final List<BannerEntity> banners = [];
    validateResponse(response);
    (response.data as List).forEach((item) {
      banners.add(BannerEntity.formJson(item));
    });
    return banners;
  }
}
