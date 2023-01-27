import 'package:exchange/models/crypto_models/all_crypto_model.dart';
import 'package:exchange/network/api_provider.dart';
import 'package:flutter/cupertino.dart';

import '../network/response_model.dart';

class MarketViewProvider extends ChangeNotifier {
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
        state = ResponseModel.error('somethings wrong, try again');
      }

      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('please check your conection');
      notifyListeners();
    }
  }
}
