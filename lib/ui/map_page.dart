import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pick_up/ui/widget/map_widget.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng locationCenterMap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            MapWidget(
              onCenterPointChange: (latLng) {
                locationCenterMap = latLng;
              },
            )
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          tooltip: 'directions',
          child: Icon(Icons.directions),
        ));
  }
}
