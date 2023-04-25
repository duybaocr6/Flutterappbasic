import 'package:flutter/material.dart';
import '../../widget/favorite_product.dart';
import '../../provider/favorite.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  static const routeName = '/favorite-product';

  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<Favorite>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: fav.items.length,
              itemBuilder: (ctx, i) => FavoriteProduct(
                fav.items.values.toList()[i].id,
                fav.items.keys.toList()[i],
                fav.items.values.toList()[i].price,
                fav.items.values.toList()[i].description,
                fav.items.values.toList()[i].title,
                fav.items.values.toList()[i].imageUrl,
                fav.items.values.toList()[i].quantity,
                fav.items.values.toList()[i].isfav,
              ),
              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: 1,
              //   childAspectRatio: 3 / 2,
              //   crossAxisSpacing: 10,
              //   mainAxisSpacing: 10,
              // ),
            ),
          )
        ],
      ),
    );
  }
}
