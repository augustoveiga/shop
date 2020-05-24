import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_grid.dart';
import 'package:shop/providers/products.dart';

enum FavoriteOption {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Products products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FavoriteOption selectedValue) {
              if(selectedValue == FavoriteOption.Favorite) {
                products.showFavoriteOnly();
              } else {
                products.showAll();
              }
            },
            icon: Icon(Icons.filter_list),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Todos'),
                value: FavoriteOption.All,
              ),
              PopupMenuItem(
                child: Text('Favoritos'),
                value: FavoriteOption.Favorite,
              ),
            ],
          )
        ],
      ),
      body: ProductGrid(),
    );
  }
}
