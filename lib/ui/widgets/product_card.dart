import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/product_model.dart';
import '../../provider/product/product_provider.dart';
import '../../provider/product/products_provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int cartCount = 0;

  void favorite() {
    final product = context.read<ProductProvider>().product;

    final productsProvider = context.read<ProductsProvider>();
    productsProvider.setFavorite(product);
  }

  bool isAddedToCart() {
    final product = context.watch<ProductProvider>().product;

    final cart = context.watch<ProductsProvider>().cart;
    if (cart.isEmpty) {
      return false;
    } else {
      if (cart.contains(product)) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductProvider>();
    // final cartsProvider = context.watch<CartsProvider>();

    return LongPressDraggable<ProductModel>(
      data: product.product,
      child: InkWell(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.product.imageFile != null)
                  Image.file(
                    product.product.imageFile!,
                    fit: BoxFit.fill,
                    height: 120,
                    width: double.infinity,
                  )
                else
                  Image.asset(
                    product.product.imageUrl,
                    fit: BoxFit.fill,
                    height: 120,
                    width: double.infinity,
                  ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  product.product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  product.product.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
                if (product.product.priceForSale != null)
                  Row(
                    children: [
                      const Text("Price"),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${product.product.priceForSale}",
                        style: const TextStyle(color: Colors.green),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      if (product.product.priceForSale != null)
                        Text(
                          "${product.product.price}",
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.red),
                        ),
                    ],
                  )
                else
                  Row(
                    children: [
                      const Text("Price"),
                      const SizedBox(
                        width: 8,
                      ),
                      Text("${product.product.price}"),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                if (isAddedToCart())
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: () => product.increaseQuantity(),
                          child: const Icon(Icons.add)),
                      Text('${product.product.cartCount}'),
                      InkWell(
                          onTap: () => product.decreaseQuantity(),
                          child: const Icon(Icons.remove))
                    ],
                  ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                product.product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      feedback: Material(
        child: Column(
          children: [
            if (product.product.imageFile != null)
              Image.file(
                product.product.imageFile!,
                fit: BoxFit.fill,
                height: 120,
                width: MediaQuery.of(context).size.width * 0.35,
              )
            else
              Image.asset(
                product.product.imageUrl,
                fit: BoxFit.fill,
                height: 120,
                width: MediaQuery.of(context).size.width * 0.35,
              ),
            const SizedBox(
              height: 8,
            ),
            Text(
              product.product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
