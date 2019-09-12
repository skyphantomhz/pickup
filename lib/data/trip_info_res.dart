import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:pick_up/data/step_res.dart';

class TripInfoRes {
  int distance;
  List<StepsRes> steps;

  TripInfoRes(this.distance, this.steps);

  static TripInfoRes fromJson(String input) {
    TripInfoRes tripInfoRes;
    final _decoder = GetIt.I<JsonDecoder>();
    try {
      var json = _decoder.convert(input);
      int distance = json["routes"][0]["legs"][0]["distance"]["value"];
      List<StepsRes> steps = _parseSteps(json["routes"][0]["legs"][0]["steps"]);
      tripInfoRes = new TripInfoRes(distance, steps);
    } catch (e) {
      throw new Exception(input);
    }
    return tripInfoRes;
  }

  static List<StepsRes> _parseSteps(final responseBody) {
    var list = responseBody
        .map<StepsRes>((json) => new StepsRes.fromJson(json))
        .toList();

    return list;
  }
}
