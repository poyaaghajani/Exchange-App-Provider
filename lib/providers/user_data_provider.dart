import 'package:exchange/models/user_model.dart';
import 'package:exchange/network/api_provider.dart';
import 'package:exchange/network/response_model.dart';
import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();

  late dynamic dataFuture;
  ResponseModel? registerStatus;
  var error;
  var response;

  callRegisterApi(name, password) async {
    // start loading api
    registerStatus = ResponseModel.loding("is loading...");
    notifyListeners();

    try {
      // fetch data from api and goto mainWrapper
      response = await apiProvider.callRegisterApi(name, password);
      if (response.statusCode == 200) {
        dataFuture = UserModel.fromJson(response.data);
        registerStatus = ResponseModel.completed(dataFuture);

        // have validate error
      } else {
        registerStatus = ResponseModel.error('somethings wrong, try again');
      }
      notifyListeners();
    } catch (e) {
      // catch any error and show error
      registerStatus = ResponseModel.error("please check your connection...");
      notifyListeners();
      print(e.toString());
    }
  }
}
