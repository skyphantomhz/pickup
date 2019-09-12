import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pick_up/data/transport_type.dart';
import 'package:pick_up/service/place_service.dart';

class PlaceRepository {
  var placeService = GetIt.I<PlaceService>();
  final _apiKey = 'AIzaSyBhDflq5iJrXIcKpeq0IzLQPQpOboX91lY';
  final _baseUrl = "https://maps.googleapis.com/maps/api";

  Future<dynamic> getStep(LatLng fromLatLng, LatLng toLatLng, TransportType transportType) async {
    String str_origin = "origin=" + fromLatLng.latitude.toString() + "," + fromLatLng.longitude.toString();
    String str_dest =
        "destination=" + toLatLng.latitude.toString() + "," + toLatLng.longitude.toString();
    String sensor = "sensor=false";
    String mode = "travelMode="+ _getTravelMode(transportType);
    String parameters = str_origin + "&" + str_dest + "&" + sensor + "&" + mode;
    String url = "$_baseUrl/directions/json?$parameters&key=$_apiKey";
    return placeService.getStep(url);
  }
    
  String _getTravelMode(TransportType transportType) {
    if(transportType == TransportType.car){
      return "DRIVING";
    }else{
      return "BICYCLING";
    }
  }
}
