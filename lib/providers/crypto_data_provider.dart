import 'package:exchange/models/crypto_models/all_crypto_model.dart';
import 'package:exchange/network/api_provider.dart';
import 'package:exchange/network/response_model.dart';
import 'package:flutter/cupertino.dart';

class CryptoDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();

  late AllCryptoModel dataFuture;
  late ResponseModel state;
  var response;

  getAllCryptoData() async {
    state = ResponseModel.loding('is loading...');

    try {
      response = await apiProvider.getAllCryptoData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('there is an error, try again');
      }
      notifyListeners();
    } catch (ex) {
      state = ResponseModel.error('please check your conection');
      notifyListeners();
    }
  }

  getTopMarketCapData() async {
    state = ResponseModel.loding('is loading...');

    try {
      response = await apiProvider.getTopMarketCapData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('there is an error, try again');
      }
      notifyListeners();
    } catch (ex) {
      state = ResponseModel.error('please check your conection');
      notifyListeners();
    }
  }

  getTopGainersData() async {
    state = ResponseModel.loding('is loading...');

    try {
      response = await apiProvider.getTopGainersData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('there is an error, try again');
      }
      notifyListeners();
    } catch (ex) {
      state = ResponseModel.error('please check your conection');
      notifyListeners();
    }
  }

  getTopLosersData() async {
    state = ResponseModel.loding('is loading...');

    try {
      response = await apiProvider.getTopLosersData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('there is an error, try again');
      }
      notifyListeners();
    } catch (ex) {
      state = ResponseModel.error('please check your conection');
      notifyListeners();
    }
  }
}
