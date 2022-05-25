import 'package:flutter/cupertino.dart';

import '../../model/product_model.dart';

export 'package:provider/provider.dart';

class ProductProvider with ChangeNotifier {
  ProductModel product;
  ProductProvider(this.product);

  void decreaseQuantity() {
    product.cartCount--;
    if (product.cartCount == 0) {
      resetCartCount();
    }

    notifyListeners();
  }

  void resetCartCount() {
    product.cartCount = 0;
    notifyListeners();
  }

  void increaseQuantity() {
    if (product.cartCount == product.numberInStock) {
      return;
    }
    product.cartCount++;
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    product.cartCount++;
    notifyListeners();
  }
}
