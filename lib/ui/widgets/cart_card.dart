import 'package:fiction_update/provider/product/products_provider.dart';
import 'package:flutter/material.dart';

import '../../provider/product/product_provider.dart';

class CartCard extends StatefulWidget {
  const CartCard({Key? key}) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductProvider>();
    final allProducts = context.watch<ProductsProvider>();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(border: Border.all()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const Text(
                    "Total Price",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    '${product.product.price}',
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () => product.increaseQuantity(),
                      child: const Icon(Icons.add)),
                  const SizedBox(
                    width: 24,
                  ),
                  Text('${product.product.cartCount}'),
                  const SizedBox(
                    width: 24,
                  ),
                  InkWell(
                    onTap: () => product.decreaseQuantity(),
                    child: const Icon(Icons.remove),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 8,
          ),
          if (product.product.imageFile != null)
            Image.file(
              product.product.imageFile!,
              fit: BoxFit.fill,
              height: 100,
              width: 150,
            )
          else
            Image.asset(
              product.product.imageUrl,
              fit: BoxFit.fill,
              height: 100,
              width: 150,
            ),
        ],
      ),
    );
  }
}
