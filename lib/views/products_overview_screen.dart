import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';

enum FavoriteOption {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FavoriteOption selectedValue) {
              setState(() {
                if (selectedValue == FavoriteOption.Favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
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
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}
