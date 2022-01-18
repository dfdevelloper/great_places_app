import 'package:flutter/material.dart';
import 'package:great_places_app/pages/place_detail_screen.dart';
import 'package:great_places_app/pages/place_form_screen.dart';
import 'package:great_places_app/pages/places_list_screen.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: PlacesListScreen(),
        routes: {
          AppRoutes.PLACE_FORM: (ctx) => PlaceFormScreen(),
          AppRoutes.PLACE_DETAIL: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
