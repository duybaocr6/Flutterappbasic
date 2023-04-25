import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/favorite.dart';
import '../screens/component/product_detail.dart';
// import '../screens/component/product_detail.dart';

class FavoriteProduct extends StatelessWidget {
  // var _editedProduct = ProductItem(
  //   id: null.toString(),
  //   title: '',
  //   description: '',
  //   price: 0,
  //   imageUrl: '',
  //   isFavorite: true,
  // );

  final String id;
  final String productId;
  final double price;
  final String description;
  final String title;
  final String imageUrl;
  final int quantity;
  bool isFav;

  FavoriteProduct(
    this.id,
    this.productId,
    this.price,
    this.description,
    this.title,
    this.imageUrl,
    this.quantity,
    this.isFav,
  );

  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<Favorite>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: productId,
        );
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${(price * quantity)}'),
          trailing: IconButton(
              onPressed: () {
                favorite.removeItem(productId);
                // if (_editedProduct.isFavorite == false) {
                // Provider.of<Products>(context, listen: false)
                //     .updateFavoriteProduct(_editedProduct);
                // }
                // Provider.of<Products>(context, listen: false)
                //     .updateFavoriteProduct(
                //         _editedProduct.isFavorite, _editedProduct);
              },
              icon: Icon(Icons.delete)),
        ),
        // ),
      ),
    );
  }
}
