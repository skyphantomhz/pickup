import 'package:flutter/material.dart';
import 'package:pick_up/ui/map_page.dart';
import 'package:pick_up/ui/transport_selection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pick up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TransportSelection(),
        '/map': (context) => MapPage(),
      },
    );
  }
}
