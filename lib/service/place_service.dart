import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pick_up/data/trip_info_res.dart';

class PlaceService {
  final http.Client client = GetIt.I<http.Client>();
  final _apiKey = 'AIzaSyBhDflq5iJrXIcKpeq0IzLQPQpOboX91lY';
  final _baseUrl = "https://maps.googleapis.com/maps/api";

  Future<dynamic> getStep(
      double lat, double lng, double tolat, double tolng) async {
    String str_origin = "origin=" + lat.toString() + "," + lng.toString();
    String str_dest =
        "destination=" + tolat.toString() + "," + tolng.toString();
    String sensor = "sensor=false";
    String mode = "mode=driving";
    String parameters = str_origin + "&" + str_dest + "&" + sensor + "&" + mode;
    String url = "$_baseUrl/directions/json?$parameters&key=$_apiKey";
    print("url: $url");
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return TripInfoRes.fromJson(response.body);
    } else {
      throw Exception("Failed to load route");
    }
  }
}
