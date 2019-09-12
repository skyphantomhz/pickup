import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:pick_up/repository/place_repository.dart';
import 'package:pick_up/service/place_service.dart';
GetIt locator = GetIt.I;
void setupLocator() {
  
  locator.registerFactory(() => PlaceService());
  locator.registerFactory(() => PlaceRepository());
  locator.registerFactory(() => Client());
  locator.registerFactory(() => JsonDecoder());
}