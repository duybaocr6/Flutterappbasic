import 'package:flutter/foundation.dart';

import '../models/favorite.dart';

class Favorite with ChangeNotifier {
  Map<String, FavoriteItem> _items = {};

  Map<String, FavoriteItem> get items {
    return {..._items};
  }

  void addItem(
    String productId,
    String title,
    String description,
    double price,
    String imageUrl,
    bool isfav,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => FavoriteItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          description: existingCartItem.description,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
          quantity: existingCartItem.quantity + 1,
          isfav: true,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => FavoriteItem(
          id: DateTime.now().toString(),
          title: title,
          description: description,
          price: price,
          imageUrl: imageUrl,
          quantity: 1,
          isfav: isfav,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(
    String productId,
  ) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
