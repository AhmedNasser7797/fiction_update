import 'package:flutter/material.dart';

import '../../model/product_model.dart';

export 'package:provider/provider.dart';

class ProductsProvider with ChangeNotifier {
  ProductsProvider() {
    products = [
      ProductModel(
        id: 1,
        name: 'product1',
        price: 50,
        description: "Description for product 1",
        numberInStock: 4,
        isFavorite: false,
        imageUrl: 'assets/images/persons-wrist-wearing.jpg',
      ),
      ProductModel(
        id: 2,
        name: 'product2',
        price: 100,
        priceForSale: 75,
        description: "Description for product 2",
        numberInStock: 3,
        isFavorite: false,
        imageUrl: 'assets/images/wrist-watches.jpg',
      ),
      ProductModel(
        id: 3,
        name: 'product3',
        price: 70,
        description: "Description for product 3",
        numberInStock: 6,
        isFavorite: false,
        imageUrl: "assets/images/photography-product-download.jpg",
      ),
    ];
    notifyListeners();
  }
  List<ProductModel> products = [];

  List<ProductModel> get favorites =>
      products.where((element) => element.isFavorite == true).toList();
  List<ProductModel> get cart =>
      products.where((element) => element.cartCount > 0).toList();

  void addProduct(ProductModel product) {
    products.add(product);
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    products.firstWhere((element) => element.id == product.id).cartCount++;
    notifyListeners();
  }

  void addToFavorite(ProductModel product) {
    products.firstWhere((element) => element == product).isFavorite = true;
    notifyListeners();
  }

  void setFavorite(ProductModel product) {
    final temp = products.firstWhere((element) => element == product);

    temp.isFavorite = !temp.isFavorite;
    notifyListeners();
  }

  double getTotalInCart() {
    double total = 0;
    if (cart.isEmpty) return 0;
    for (var element in cart) {
      if (element.priceForSale != null) {
        total += (element.priceForSale!) * element.cartCount;
      } else {
        total += element.price * element.cartCount;
      }
    }
    return total;
  }
}
