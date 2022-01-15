import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/models/places.dart';
import 'package:great_places_app/utils/db_util.dart';

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

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map(
          (item) => Place(
              id: item['id'],
              title: item['title'],
              img: File(item['image']),
              location: null),
        )
        .toList();
    notifyListeners();
  }

  Future<void> addPlace(String title, File image) async {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      img: image,
      title: title,
    );

    _items.add(newPlace);

    await DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.img.path,
    });

    notifyListeners();
  }
}
