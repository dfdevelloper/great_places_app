import 'package:flutter/foundation.dart';
import 'package:great_places_app/models/places.dart';

class GreatPlaces with ChangeNotifier{
  List<Place> _items = [];

  List<Place> get items{
    return [..._items];
  }

  int get itemsCount{
    return _items.length;
  }

  Place itemByIndex(int index){
    return _items[index];
  }
}