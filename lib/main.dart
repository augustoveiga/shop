import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './utils/app_routes.dart';

import './views/product_detail_screen.dart';
import './views/cart_screen.dart';
import './views/orders_screen.dart';
import './views/products_screen.dart';
import './views/product_form_screen.dart';
import './views/auth_home_screen.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Criando um novo ChangeNotifier a partir do metodo create
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => new Products(),
          update: (ctx, auth, previousProducts) => new Products(
            auth.token,
            auth.userId,
            previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => new Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => new Orders(),
          update: (ctx, auth, previousOrders) => new Orders(
            auth.token,
            auth.userId,
            previousOrders.items,
          ),
        )
      ],
      child: MaterialApp(
          title: 'Minha Loja',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          //home: ProductOverviewScreen(),
          routes: {
            AppRoutes.AUTH_HOME: (_) => AuthOrHomeScreen(),
            AppRoutes.PRODUCT_DETAIL: (_) => ProductDetailScreen(),
            AppRoutes.CART: (_) => CartScreen(),
            AppRoutes.ORDERS: (_) => OrderScreen(),
            AppRoutes.PRODUCTS: (_) => ProductsScreen(),
            AppRoutes.PRODUCT_FORM: (_) => ProductFormScreen(),
          }),
    );
  }
}
