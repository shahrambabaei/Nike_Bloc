import 'package:dio/dio.dart';
import 'package:nike/configs/exceptions.dart';

mixin HttpResponseValidatore{
  
  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }

}