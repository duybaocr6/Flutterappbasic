import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/product_item.dart';

import '../provider/products.dart';

class DisplayProduct extends StatelessWidget {
// final String id;
  // final String title;
  // final String imageUrl;
  // final double price;
  // bool isFavorite;

  // ProductItem(this.id, this.title, this.imageUrl, this.price, this.isFavorite);

  // final bool showFavorite;

  // DisplayProduct(this.showFavorite);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    // final products =
    //     showFavorite ? productsData.favoriteItems : productsData.items;
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItems(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            // products[i].price,
            // products[i].isFavorite,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
