import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pick_up/data/trip_info_res.dart';

class PlaceService {
  final http.Client client = GetIt.I<http.Client>();

  Future<dynamic> getStep(String url) async {
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return TripInfoRes.fromJson(response.body);
    } else {
      throw Exception("Failed to load route");
    }
  }
}
