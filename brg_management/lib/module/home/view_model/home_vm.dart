import 'package:brg_management/data/repositories/home_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../configs/app_localizations.dart';
import '../../../core/utils/isEmpty.dart';
import '../../../data/model/base_response_api.dart';
import '../../../data/model/home_data.dart';
import '../../../data/model/response.dart';
import '../../../main.dart';

class HomeViewModel extends ChangeNotifier {
  HomeApi homeApi = HomeApi();
  BaseResponseApi? homeResponse;
  HomeData? homeData;
  List<ModuleData> moduleData = [];

  void initViewModel() {
    homeResponse = null;
    homeData = new HomeData(moduleData);
    getHomeData();
  }

  void getHomeData() async {
    EasyLoading.show();

    ApiResponse json = await homeApi.getHomeData();
    if (json.success & !isEmpty(json.responseObject)) {
      homeResponse = BaseResponseApi<HomeData>.fromJson(json.responseObject,
          compileData: (data) => !isEmpty(json.responseObject['Data'])
              ? HomeData.fromJson(json.responseObject['Data'])
              : HomeData(moduleData));
      if (homeResponse!.isSuccess!) {
        homeData = homeResponse!.data!;
        //print(homeData!.moduleData![0]);

      }
      EasyLoading.dismiss();
    } else {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(
                  NavigationService.navigatorKey.currentContext!)!
              .translate('khong_co_du_lieu'),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      EasyLoading.dismiss();
    }
  }
}
