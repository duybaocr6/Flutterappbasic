import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/notification.dart';
import '../../widget/notification_product.dart';

class NotificationPage extends StatelessWidget {
  static const routeName = '/notification-product';

  @override
  Widget build(BuildContext context) {
    // final notificationData = Provider.of<Notifications>(context);
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<Notifications>(context, listen: false)
            .fecthAndSetNotification(),
        builder: (ctx, dataSnapshort) {
          if (dataSnapshort.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshort.error != null) {
              return Center(
                child: Text('An error occurred'),
              );
            } else {
              return Consumer<Notifications>(
                builder: (ctx, notificationData, child) => ListView.builder(
                  itemCount: notificationData.notifications.length,
                  itemBuilder: (ctx, i) =>
                      NotificationProduct(notificationData.notifications[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
