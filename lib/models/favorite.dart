import 'package:flutter/foundation.dart';

class FavoriteItem with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final int quantity;
  bool isfav;

  FavoriteItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.isfav,
  });
}
