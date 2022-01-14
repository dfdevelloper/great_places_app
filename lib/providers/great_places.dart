import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/models/places.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      img: image,
      title: title,
    );

    _items.add(newPlace);

    notifyListeners();
  }
}
