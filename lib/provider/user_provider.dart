import 'package:flutter/material.dart';
import 'package:tafeel_task/data/model/response/base/api_response.dart';
import 'package:tafeel_task/data/model/response/user_model.dart';
import 'package:tafeel_task/data/repository/user_repo.dart';
import 'package:tafeel_task/helper/api_checker.dart';

class UserProvider with ChangeNotifier {
  final UserRepo? userRepo;

  UserProvider({@required this.userRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  UserModel? _userDataModel;

  UserModel? get userDataModel => _userDataModel;

  final List<UserModel> _listUserModel = [];

  List<UserModel>? get listUserModel => _listUserModel;

  Future<bool> getUserListApi({context, int? currentPage}) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await userRepo!.getUserListApi(
      currentPage: currentPage,
    );
    print(apiResponse.error);
    print("apiResponse.error");
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      print(apiResponse.response!.data['data']);
      for (var item in apiResponse.response!.data['data']) {
        _listUserModel.add(UserModel.fromJson(item));
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      ApiChecker.checkApi(apiResponse);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> getUserDataApi({context,  idUser}) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await userRepo!.getUserDataApi(idUser: idUser);
    _isLoading = false;

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _userDataModel = UserModel.fromJson(apiResponse.response!.data['data']);
      notifyListeners();
      return true;
    } else {
      ApiChecker.checkApi(apiResponse);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
