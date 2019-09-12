import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pick_up/bloc/map_bloc.dart';
import 'package:pick_up/ui/widget/map_widget.dart';
import 'package:rxdart/rxdart.dart';

class MapPage extends StatefulWidget {
  bool isDestinationSelected = false;
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng locationCenterMap;

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Scaffold(
        body: Stack(
          children: <Widget>[
            MapWidget(
              onCenterPointChange: (latLng) {
                locationCenterMap = latLng;
              },
            ),
            Align(
              alignment: Alignment.center,
              child: StreamBuilder(
                stream: mapBloc.isDestinationSelected,
                initialData: true,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  widget.isDestinationSelected = snapshot.data;
                  return Icon(
                    Icons.add_location,
                    size: 40,
                    color: snapshot.data ? Colors.black : Colors.transparent,
                  );
                },
              ),
            )
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            mapBloc.onFloatButtonClick(widget.isDestinationSelected);
          },
          tooltip: 'directions',
          child: StreamBuilder(
            stream: mapBloc.isDestinationSelected,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Icon(
                  snapshot.data ? Icons.directions : Icons.delete_outline);
            },
          ),
        ));
  }
}
