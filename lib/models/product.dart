import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProductItem with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  ProductItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
  void toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
        'https://flutter-project-364fb-default-rtdb.firebaseio.com/products/$id.json');
    try {
      await http.patch(url,
          body: json.encode({
            'isFavorite': isFavorite,
          }));
    } catch (e) {
      isFavorite = oldStatus;
    }
  }
}
