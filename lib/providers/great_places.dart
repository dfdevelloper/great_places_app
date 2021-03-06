import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_app/models/places.dart';
import 'package:great_places_app/utils/db_util.dart';
import 'package:great_places_app/utils/location_util.dart';

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
            location: item['lat'] != null ? PlaceLocation(
              latitude: item['lat'],
              longitude: item['lng'],
              address: item['address'],
            ) : null,
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> addPlace(
    String title,
    File image,
    LatLng position,
  ) async {
    final address = await LocationUtil.getAddressFrom(position);

    final newPlace = Place(
      id: Random().nextDouble().toString(),
      img: image,
      title: title,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
    );

    _items.add(newPlace);

    await DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.img.path,
      'lat': position.latitude,
      'lng': position.longitude,
      'address': address,
    });

    notifyListeners();
  }
}
