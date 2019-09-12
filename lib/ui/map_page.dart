import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pick_up/bloc/map_bloc.dart';
import 'package:pick_up/data/transport_type.dart';
import 'package:pick_up/ui/widget/map_widget.dart';

class MapPage extends StatefulWidget {
  bool isDestinationSelected = false;
  static const routeName = '/map';
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapBloc mapBloc;
  TransportType transportType;

  @override
  Widget build(BuildContext context) {
    mapBloc = BlocProvider.of<MapBloc>(context);
    mapBloc.transportType = ModalRoute.of(context).settings.arguments;
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              initialChildSize: 0.20,
              minChildSize: 0.20,
              maxChildSize: 1,
              builder: (BuildContext context, ScrollController controller) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: _searchDestination(controller),
                );
              },
            ),
          ),
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

  Widget _searchDestination(ScrollController controller) {
    return ListView(
      controller: controller,
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 178, 183, 249),
                borderRadius: BorderRadius.all(Radius.elliptical(50, 50))),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.my_location),
            ),
            initialValue: "Your location",
            enabled: false,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          child: TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.location_on),
            ),
            initialValue: "Choose destination",
            enabled: false,
          ),
        ),
      ],
    );
  }
}
