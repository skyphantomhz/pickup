import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:pick_up/bloc/map_bloc.dart';
import 'package:pick_up/ui/map_page.dart';
import 'package:pick_up/ui/transport_selection.dart';
import 'package:pick_up/util/locator.dart';

void main() {
  setupLocator();
  runApp(
    BlocProvider<MapBloc>(
      creator: (_context, _bag) => MapBloc(),
      child: MyApp(),
    ),
  );
}

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
        TransportSelection.routeName: (context) => TransportSelection(),
        MapPage.routeName: (context) => MapPage(),
      },
    );
  }
}
