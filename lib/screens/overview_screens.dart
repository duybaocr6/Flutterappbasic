import 'package:flutter/material.dart';
import '../screens/component/manager.dart';
import '../screens/component/cart.dart';
import 'package:provider/provider.dart';

import '../../provider/carts.dart';
import '../screens/component/home.dart';
import '../screens/component/favorite.dart';
import '../widget/number_cart.dart';
import '../screens/component/notification.dart';

class OverviewScreens extends StatefulWidget {
  static const routeName = '/main';

  @override
  State<OverviewScreens> createState() => _OverviewScreensState();
}

class _OverviewScreensState extends State<OverviewScreens> {
  int pageIndex = 0;

  final pages = [
    HomePage(),
    FavoritePage(),
    CartPage(),
    ManagerPage(),
    NotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildMyNavBar(context),
      body: Container(
        height: double.infinity,
        child: pages[pageIndex],
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Color.fromARGB(221, 1, 22, 42),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.favorite_outlined,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.favorite_outline_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
                    Icons.business_center,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.business_center_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 4;
              });
            },
            icon: pageIndex == 4
                ? const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => NumberCart(
              child: ch!,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                      Icons.shopping_cart_rounded,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
