import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pick_up/bloc/map_bloc.dart';
import 'package:pick_up/ui/widget/map_widget.dart';

class MapPage extends StatefulWidget {
  bool isDestinationSelected = false;
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapBloc mapBloc;

  @override
  Widget build(BuildContext context) {
    mapBloc = BlocProvider.of<MapBloc>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MapWidget(),
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: mapBloc.isDestinationSelected,
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                widget.isDestinationSelected = snapshot.data;
                return Icon(
                  Icons.add_location,
                  size: 40,
                  color: snapshot.data ? Colors.transparent : Colors.black,
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
                snapshot.data ? Icons.delete_outline : Icons.directions);
          },
        ),
      ),
    );
  }
}
