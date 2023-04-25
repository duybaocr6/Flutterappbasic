import './cart.dart';

class NotificationItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  NotificationItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}
