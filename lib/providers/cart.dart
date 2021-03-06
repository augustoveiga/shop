import 'dart:math';

import 'package:flutter/foundation.dart';
import './product.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int qunatity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.productId,
      @required this.title,
      @required this.price,
      @required this.qunatity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  //Retorna a quantidade de itens dentro do carrinho
  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.qunatity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) {
          return CartItem(
            id: existingItem.id,
            productId: product.id,
            title: existingItem.title,
            price: existingItem.price,
            qunatity: existingItem.qunatity + 1,
          );
        },
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
            id: Random().nextDouble().toString(),
            productId: product.id,
            title: product.title,
            qunatity: 1,
            price: product.price),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId].qunatity == 1) {
      items.remove(productId);
    } else {
      _items.update(
        productId,
        (existingItem) {
          return CartItem(
            id: existingItem.id,
            productId: existingItem.productId,
            title: existingItem.title,
            price: existingItem.price,
            qunatity: existingItem.qunatity - 1,
          );
        },
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
