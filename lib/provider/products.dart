import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class Products with ChangeNotifier {
  List<ProductItem> _items = [
    // ProductItem(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //   // isFavorite: false,
    // ),
    // ProductItem(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //   // isFavorite: false,
    // ),
    // ProductItem(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //   // isFavorite: false,
    // ),
    // ProductItem(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   // isFavorite: false,
    // ),
    // ProductItem(
    //   id: 'p5',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //   // isFavorite: false,
    // ),
    // ProductItem(
    //   id: 'p6',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //   // isFavorite: false,
    // ),
    // ProductItem(
    //   id: 'p7',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //   // isFavorite: false,
    // ),
    // ProductItem(
    //   id: 'p8',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  // var _showFavoritesOnly = false;

  List<ProductItem> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  // List<Product> get favoriteItems {
  //   return _items.where((prodItem) => prodItem.isFavorite).toList();
  // }

  ProductItem findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://ecommerceapps-fe735-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }
      final List<ProductItem> loadProducts = [];
      extractedData.forEach((proId, proData) {
        loadProducts.add(
          ProductItem(
            id: proId,
            title: proData['title'],
            description: proData['description'],
            price: proData['price'],
            imageUrl: proData['imageUrl'],
            isFavorite: proData['isFavorite'],
          ),
        );
      });
      _items = loadProducts;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> addProduct(ProductItem product) async {
    final url = Uri.parse(
        'https://ecommerceapps-fe735-default-rtdb.firebaseio.com/products.json');
    try {
      final value = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = ProductItem(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(value.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> updateProduct(String id, ProductItem newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://ecommerceapps-fe735-default-rtdb.firebaseio.com/products/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  // void updateFavoriteProduct(ProductItem updatefavorite) {
  //   final _showFavoritesOnly =
  //       _items.indexWhere((prod) => prod.isFavorite == updatefavorite);
  //   //   if (prodfav == true) {
  //   //     _items[prodfav] = favorite;
  //   //     notifyListeners();
  //   //   } else {
  //   //     print('...');
  //   //   }
  // }

  void deleteProduct(String id) {
    final url = Uri.parse(
        'https://ecommerceapps-fe735-default-rtdb.firebaseio.com/products/$id.json');
    final exitingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var exitingProduct = _items[exitingProductIndex];
    _items.removeAt(exitingProductIndex);
    notifyListeners();
    http.delete(url);
  }
}
