import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pick_up/data/transport_type.dart';
import 'package:pick_up/ui/map_page.dart';
import 'package:pick_up/ui/widget/transport_item.dart';

class TransportSelection extends StatefulWidget {

  static const routeName = '/';

  TransportSelection({Key key}) : super(key: key);

  @override
  _TransportSelectionState createState() => _TransportSelectionState();
}

class _TransportSelectionState extends State<TransportSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TransportItem(
                transport: TransportType.car,
                icon: Icons.directions_car,
                onSelected: _onSelectTransport),
            SizedBox(
              width: 40,
            ),
            TransportItem(
                transport: TransportType.bike,
                icon: Icons.directions_bike,
                onSelected: _onSelectTransport),
          ],
        ),
      ),
    );
  }

  _onSelectTransport(TransportType transport) {
    Navigator.pushNamed(
      context,
      MapPage.routeName,
      arguments: transport,);
  }
}
