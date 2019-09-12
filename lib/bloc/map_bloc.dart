import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pick_up/repository/place_repository.dart';
import 'package:rxdart/rxdart.dart';

class MapBloc extends Bloc {
  final placeRepository = GetIt.I<PlaceRepository>();

  BehaviorSubject<Polyline> _polyline = BehaviorSubject<Polyline>();
  Observable<Polyline> get polyline => _polyline.stream;

  PublishSubject<bool> _isDestinationSelected = PublishSubject<bool>();
  Observable<bool> get isDestinationSelected => _isDestinationSelected.stream;

  void getRoute(LatLng fromLatLng, LatLng toLatLng) async {
    final tripInfoRes = await placeRepository.getStep(fromLatLng, toLatLng);

    final route = List<LatLng>();
    route.add(fromLatLng);
    tripInfoRes.steps.forEach((step) {
      route.add(step.endLocation);
    });
    addRoute(route, fromLatLng);
  }

  void addRoute(List<LatLng> route, LatLng fromLatLng) {
    _polyline.sink.add(Polyline(
      polylineId: PolylineId(fromLatLng.toString()),
      visible: true,
      points: route,
      color: Colors.blue,
    ));
  }

  void onFloatButtonClick(bool currentState) {
    _isDestinationSelected.sink.add(!currentState);
  }

  @override
  void dispose() {
    _polyline.close();
  }

  void clearData() {
    _polyline.sink.add(Polyline(polylineId: PolylineId(""), visible: false));
  }
}