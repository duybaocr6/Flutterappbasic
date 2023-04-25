import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce/screens/component/favorite.dart';
import '../models/product.dart';
import '../provider/favorite.dart';
import 'package:provider/provider.dart';

import '../../provider/carts.dart';
import '../screens/component/product_detail.dart';

class ProductItems extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // final double price;
  // bool isFavorite;

  // ProductItem(this.id, this.title, this.imageUrl, this.price, this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductItem>(context, listen: false);
    final favorite = Provider.of<Favorite>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    // final carts = Provider.of<CartItem>(context, listen: false);
    return Container(
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Color.fromARGB(221, 1, 22, 42),
            leading: Consumer<ProductItem>(
              builder: (ctx, product, _) => IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  product.toggleFavoriteStatus();
                  favorite.addItem(
                    product.id,
                    product.title,
                    product.description,
                    product.price,
                    product.imageUrl,
                    product.isFavorite,
                  );
                },
              ),
            ),
            title: Text(
              '${product.title}',
              textAlign: TextAlign.start,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Added item to cart!',
                    ),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
