import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pick_up/service/place_service.dart';

class PlaceRepository{
  var placeService = GetIt.I<PlaceService>();

  Future<dynamic> getStep(LatLng fromLatLng, LatLng toLatLng) async {
    return placeService.getStep(fromLatLng.latitude, fromLatLng.longitude, toLatLng.latitude, toLatLng.longitude);
  }
}