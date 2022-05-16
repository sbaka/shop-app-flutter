// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String title;
  final String imgUrl;
  final double price;
  final double quantity;
  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imgUrl,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double helper = 0.0;
    items.forEach(
      (key, value) {
        helper += value.price * value.quantity;
      },
    );
    return helper;
  }

  void toggleCart(String productId, String title, String imgUrl, double price) {
    if (_items.containsKey(productId)) {
      // _items.update(
      //   productId,
      //   (existingValue) => CartItem(
      //     id: existingValue.id,
      //     title: existingValue.title,
      //     price: existingValue.price,
      //     quantity: existingValue.quantity + 1,
      //   ),
      // );
      _items.remove(productId);
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          imgUrl: imgUrl,
          price: price,
          quantity: 1,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
