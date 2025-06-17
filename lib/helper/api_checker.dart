import 'package:flutter/material.dart';
import 'package:tafeel_task/data/model/response/base/api_response.dart';
import 'package:tafeel_task/main.dart';

class ApiChecker {
  static void checkApi(ApiResponse apiResponse) async {
    if (apiResponse.error is! String &&
        apiResponse.error.errors[0].message == 'unauthorized.') {
    } else if (apiResponse.error == 'block user' ||
        apiResponse.error == 'unauthorized') {

    } else if(apiResponse.response!.statusCode==404){
      print("not found");
    }else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red));
    }
  }
}
