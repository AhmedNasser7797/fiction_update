import '../model/product_model.dart';

class FakeDataProducts {
  static final List<ProductModel> _products = [
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
}
