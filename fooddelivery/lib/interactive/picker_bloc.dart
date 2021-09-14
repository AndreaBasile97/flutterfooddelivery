import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:fooddelivery/interactive/location.dart';

class PickerBloc with ChangeNotifier {
  StreamController<Location> locationController =
      StreamController<Location>.broadcast();
  Location currentLocation;
  static const mapKey = 'AIzaSyBEk9pdDV-HuHQd_SgAx9FUDLr8O41Fzn4';

  static PickerBloc _instance;
  static PickerBloc getInstance() {
    if (_instance == null) {
      _instance = PickerBloc._internal();
    }
    return _instance;
  }

  PickerBloc._internal();

  Future<List<Location>> search(String query) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$mapKey";
    Response response = await Dio().get(url);
    return Location.parseLocationList(response.data);
  }

  void dispose() {
    print('close');
    _instance = null;
    locationController.close();
  }
}
