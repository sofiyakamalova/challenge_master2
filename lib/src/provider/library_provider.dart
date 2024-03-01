import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LibraryProvider extends ChangeNotifier {
  final Box _itemBox = Hive.box('my_challenges');

  List foundBooks = [];

  void init() {
    foundBooks = _itemBox.values.toList();
    print('init');
  }

  List get books => foundBooks;

  void runFilter(String category) {
    List results = [];
    if (category.isEmpty) {
      results = foundBooks;
    } else {
      results = foundBooks
          .where(
              (book) => book.category.toLowerCase() == (category.toLowerCase()))
          .toList();
    }

    foundBooks = results;
    notifyListeners();
  }
}
