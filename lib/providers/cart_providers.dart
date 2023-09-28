import 'dart:developer';

import 'package:bake_store/providers/product_class.dart';
import 'package:flutter/foundation.dart';

class Cart extends ChangeNotifier {
  final List<Product> _list = [];

  double _totalprice = 0.0;

  List<Product> get getItems {
    return _list;
  }

  double get totalPrice {
    var total = 0.0;

    for (var item in _list) {
      log("itemPrice${item.price},item qty${item.qty}");
      total += item.price * item.qty;
    }
    _totalprice = total;

    log(_totalprice.toString());

    return _totalprice;
  }

  int? get count {
    return _list.length;
  }

  void addItem({
    required String name,
    required double price,
    required int qty,
    required int qntty,
    required List imagesUrl,
    required String documentId,
    required String suppId,
  }) {
    final product = Product(
        name: name,
        price: price,
        qty: qty,
        qntty: qntty,
        imagesUrl: imagesUrl,
        documentId: documentId,
        suppId: suppId);
    _list.add(product);
    notifyListeners();
  }

  void increment(Product product) {
    product.increase();
    notifyListeners();
  }

  void decrement(Product product) {
    product.decrease();
    var newPrice = _totalprice - product.price;
    _totalprice = newPrice;
    notifyListeners();
  }

  void removeItem(Product product) {
    var newPrice = _totalprice - product.price;
    _totalprice = newPrice;
    _list.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _list.clear();
    _totalprice = 0.0;
    notifyListeners();
  }
}
