import 'package:dio/dio.dart';
import 'package:nike/data/repo/auth_repository.dart';

final httpClient =
    Dio(BaseOptions(baseUrl: 'http://expertdevelopers.ir/api/v1/'))
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          final authInfo = AuthRepository.authChangeNotifier.value;
          if (authInfo != null && authInfo.accesstoken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer ${authInfo.accesstoken}';
          }
          handler.next(options); 
        },
      ));
