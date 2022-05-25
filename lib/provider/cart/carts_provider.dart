// import 'package:flutter/cupertino.dart';
//
// import '../../model/cart_model.dart';
// import '../../model/product_model.dart';
//
// export 'package:provider/provider.dart';
//
// class CartsProvider with ChangeNotifier {
//   List<CartModel> cart = [];
//   double getTotalInCart() {
//     double total = 0;
//     if (cart.isEmpty) return 0;
//     for (var element in cart) {
//       if (element.product.priceForSale != null) {
//         total += (element.product.priceForSale!) * element.cartCount;
//       } else {
//         total += element.product.price * element.cartCount;
//       }
//     }
//     return total;
//   }
//
//   void decreaseQuantity(int productId) {
//     CartModel selectedItem =
//         cart.firstWhere((CartModel element) => element.product.id == productId);
//
//     selectedItem.cartCount--;
//     if (selectedItem.cartCount == 0) {
//       cart.remove(selectedItem);
//     }
//
//     notifyListeners();
//   }
//
//   void increaseQuantity(int productId) {
//     CartModel selectedItem =
//         cart.firstWhere((CartModel element) => element.product.id == productId);
//     if (selectedItem.cartCount == selectedItem.product.numberInStock) {
//       return;
//     }
//     selectedItem.cartCount++;
//     notifyListeners();
//   }
//
//   void addToCart(ProductModel product) {
//     cart.add(
//       CartModel(
//         product: product,
//         cartCount: 1,
//       ),
//     );
//     notifyListeners();
//   }
// }
