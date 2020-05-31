import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_grid_item.dart';
import '../providers/products.dart';

class ProductGrid extends StatelessWidget {
  final bool _showFavoriteOnly;

  ProductGrid(this._showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    //final List<Product> loadedProducts = Provider.of<Products>(context).items;
    final productsProvider = Provider.of<Products>(context);
    final products = _showFavoriteOnly
        ? productsProvider.favoriteItems
        : productsProvider.items;
        
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: products.length,
      //Provider ja existente, definido dentro de product.dart
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductGridItem(),
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
