import 'dart:developer';

import 'package:fiction_update/model/product_model.dart';
import 'package:fiction_update/utils/help_functions.dart';
import 'package:flutter/material.dart';

import '../../provider/product/product_provider.dart';
import '../../provider/product/products_provider.dart';
import '../widgets/product_card.dart';
import 'add_product_screen.dart';
import 'cart_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool onWillAccept(ProductModel? product) {
    log('on onWillAccept cart');
    final productsProvider = context.read<ProductsProvider>();

    for (var element in productsProvider.cart) {
      if (element.id == product?.id) {
        HelpFunctions().showSnackBar('already added to cart!', context);
        return false;
      }
    }
    productsProvider.addToCart(product!);
    HelpFunctions().showSnackBar('added to cart!', context);

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = context.watch<ProductsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("total ${productsProvider.getTotalInCart()}"),
                const SizedBox(
                  width: 40,
                ),
                DragTarget<ProductModel>(
                  hitTestBehavior: HitTestBehavior.opaque,
                  onWillAccept: (product) => onWillAccept(product),
                  builder:
                      (BuildContext context, candidateData, rejectedData) =>
                          Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        ),
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 0.5),
                        ),
                        child: Text(
                          "${productsProvider.cart.length}",
                          style: const TextStyle(
                              fontSize: 10, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: productsProvider.products.length,
                      itemBuilder: (context, int i) =>
                          ChangeNotifierProvider<ProductProvider>(
                              create: (_) =>
                                  ProductProvider(productsProvider.products[i]),
                              child: const ProductCard()),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.6,
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                    ),
                  ),
                  DragTarget(
                    hitTestBehavior: HitTestBehavior.opaque,
                    onWillAccept: (ProductModel? product) {
                      if (product?.isFavorite ?? false) {
                        HelpFunctions()
                            .showSnackBar('already added to favorite', context);
                      } else {
                        productsProvider.addToFavorite(product!);
                        HelpFunctions()
                            .showSnackBar('added to favorite!', context);
                      }

                      return false;
                    },
                    builder:
                        (BuildContext context, candidateData, rejectedData) =>
                            InkWell(
                      // onTap: () => Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => FavoritesScreen(),
                      //   ),
                      // ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => const AddProductScreen(),
          ),
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
