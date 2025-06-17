import 'package:tafeel_task/data/datasource/remote/dio/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:tafeel_task/data/datasource/remote/exception/api_error_handler.dart';
import 'package:tafeel_task/data/model/response/base/api_response.dart';
import 'package:tafeel_task/utils/app_constants.dart';

class UserRepo {
  final DioClient? dioClient;

  UserRepo({this.dioClient});


  Future<ApiResponse> getUserListApi({int? currentPage,}) async {
    try {
      Response response = await dioClient!.get('${AppConstants.userListUri}$currentPage');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getUserDataApi({int?idUser}) async {
    try {
      print('${AppConstants.userUri}$idUser');
      Response response = await dioClient!.get('${AppConstants.userUri}$idUser');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
