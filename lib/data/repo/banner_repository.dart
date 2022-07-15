import 'package:nike/configs/http_client.dart';
import 'package:nike/data/models/banner.dart';
import 'package:nike/data/source/banner_datasource.dart';

final bannerRepository = BannerRepository(BannerRemoteDataSource(httpClient));

abstract class IBannerRepository {
  Future<List<BannerEntity>> getAll();
}

class BannerRepository implements IBannerRepository {
  final IBannerDataSource dataSource;

  BannerRepository(this.dataSource);
  @override
  Future<List<BannerEntity>> getAll() => dataSource.getAll();
}
