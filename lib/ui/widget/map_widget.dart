import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:pick_up/bloc/map_bloc.dart';

class MapWidget extends StatefulWidget {
  ValueChanged<LatLng> onCenterPointChange;

  MapWidget({this.onCenterPointChange});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  StreamSubscription<LocationData> _locationSubscription;
  var _locationService = new Location();
  bool _permission = false;
  LocationData _startLocation;
  LocationData _currentLocation;
  LatLng _destinationLocation;
  CameraPosition _currentCameraPosition;
  String error;
  bool destinationWasSelected = false;
  static final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(0, 0),
    zoom: 4,
  );

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.BALANCED, interval: 10000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();
          updateCameraPosition(location);
          _locationSubscription = _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            if (destinationWasSelected) {
              updateCameraPosition(result);
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _startLocation = location;
    });
  }

  void updateCameraPosition(LocationData locationData) async {
    _currentCameraPosition = CameraPosition(
        target: LatLng(locationData.latitude, locationData.longitude),
        zoom: 16);

    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(_currentCameraPosition));

    if (mounted) {
      setState(() {
        _currentLocation = locationData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<Polyline>(
          stream: mapBloc.polyline,
          initialData: Polyline(
            polylineId: PolylineId("abc"),
          ),
          builder: (context, snap) {
            return GoogleMap(
              polylines: Set.from([snap.data]),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
              initialCameraPosition: _initialCamera,
              onCameraMove: (CameraPosition cameraPosition) {
                widget.onCenterPointChange(cameraPosition.target);
              },
              onLongPress: (location) {
                _destinationLocation = location;
                _moveCamera();
                mapBloc.getRoute(
                    LatLng(
                        _currentLocation.latitude, _currentLocation.longitude),
                    _destinationLocation);
              },
            );
          }),
    );
  }

  void _moveCamera() async {
    var fromLatLng =
        LatLng(_currentLocation.latitude, _currentLocation.longitude);
    var toLatLng = _destinationLocation;

    var sLat, sLng, nLat, nLng;
    if (fromLatLng.latitude <= toLatLng.latitude) {
      sLat = fromLatLng.latitude;
      nLat = toLatLng.latitude;
    } else {
      sLat = toLatLng.latitude;
      nLat = fromLatLng.latitude;
    }

    if (fromLatLng.longitude <= toLatLng.longitude) {
      sLng = fromLatLng.longitude;
      nLng = toLatLng.longitude;
    } else {
      sLng = toLatLng.longitude;
      nLng = fromLatLng.longitude;
    }

    LatLngBounds bounds = LatLngBounds(
        northeast: LatLng(nLat, nLng), southwest: LatLng(sLat, sLng));
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }
}
