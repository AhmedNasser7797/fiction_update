import 'package:fiction_update/provider/product/product_provider.dart';
import 'package:fiction_update/provider/product/products_provider.dart';
import 'package:flutter/material.dart';

import '../widgets/cart_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<ProductsProvider>().cart;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart Screen',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        automaticallyImplyLeading: true,
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text('no product added in cart yet!'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cart.length,
              itemBuilder: (context, int i) =>
                  ChangeNotifierProvider<ProductProvider>(
                create: (_) => ProductProvider(cart[i]),
                child: const CartCard(),
              ),
            ),
    );
  }
}
