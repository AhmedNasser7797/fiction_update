import 'package:fiction_update/model/product_model.dart';

class CartModel {
  ProductModel product = ProductModel.temp();
  int cartCount = 0;

  CartModel({
    required this.product,
    required this.cartCount,
  });
}
