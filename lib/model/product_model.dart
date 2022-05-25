import 'dart:io';

class ProductModel {
  int id = 0;
  String name = "";
  String description = "";
  double price = 0;
  double? priceForSale = 0;
  String imageUrl = "";
  File? imageFile;
  bool isFavorite = false;
  int numberInStock = 0;
  int cartCount = 0;

  ProductModel.temp();
  ProductModel({
    required this.description,
    required this.id,
    required this.imageUrl,
    this.isFavorite = false,
    required this.price,
    required this.name,
    required this.numberInStock,
    this.priceForSale,
    this.imageFile,
  });
}
