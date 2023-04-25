import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';
import '../models/notification.dart';

class Notifications with ChangeNotifier {
  List<NotificationItem> _notifications = [];

  List<NotificationItem> get notifications {
    return [..._notifications];
  }

  Future<void> fecthAndSetNotification() async {
    final url = Uri.parse(
        'https://flutter-project-364fb-default-rtdb.firebaseio.com/order.json');
    final response = await http.get(url);
    final List<NotificationItem> loadednotifications = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach(
      (notificationId, notificationData) {
        loadednotifications.add(NotificationItem(
          id: notificationId,
          amount: notificationData['amount'],
          products: (notificationData['products'] as List<dynamic>)
              .map((e) => CartItem(
                    id: e['id'],
                    title: e['title'],
                    quantity: e['quantity'],
                    price: e['price'],
                  ))
              .toList(),
          dateTime: DateTime.parse(notificationData['dateTime']),
        ));
      },
    );
    _notifications = loadednotifications.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://flutter-project-364fb-default-rtdb.firebaseio.com/order.json');
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'price': e.price,
                    'quantity': e.quantity,
                  })
              .toList(),
        }));
    _notifications.insert(
      0,
      NotificationItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
