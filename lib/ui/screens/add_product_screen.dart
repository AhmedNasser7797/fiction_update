import 'dart:developer';
import 'dart:io';

import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/product_model.dart';
import '../../provider/product/products_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/error_pop_up.dart';
import '../widgets/simple_textfield.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _autoValidate = false;
  ProductModel product = ProductModel.temp();

  ///////////// image picker from user ///////////
  Future<void> pickImage() async {
    final pFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pFile != null) {
      product.imageFile = File(pFile.path);
      if (mounted) setState(() {});
    }
  }

  Future<void> takeImage() async {
    final pFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pFile != null) product.imageFile = File(pFile.path);
    if (mounted) setState(() {});
  }

  void removeImage() => setState(() => product.imageFile = null);

  //////////////// firebase storage /////////////

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autoValidate = true);
      return;
    }
    if (product.imageFile == null) {
      return showDialog(
        context: context,
        builder: (ctx) =>
            const ErrorPopUp(message: 'please Choose Product Image!'),
      );
    }
    if (product.priceForSale != null &&
        product.priceForSale! >= product.price) {
      return showDialog(
        context: context,
        builder: (ctx) =>
            const ErrorPopUp(message: 'price for sale should less than price!'),
      );
    }

    _formKey.currentState!.save();

    try {
      final productsProvider = context.read<ProductsProvider>();
      product.id = DateTime.now().millisecondsSinceEpoch;
      productsProvider.addProduct(product);
      Navigator.pop(context);
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => const ErrorPopUp(
            message: "Something Went Wrong! please try again."),
      );

      log('error add product ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Product',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (product.imageFile == null) ...{
                GestureDetector(
                  onTap: openWithPopUp,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffffffff),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1a000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/images/product-placeholder.png',
                        width: 103,
                        height: 103,
                      ),
                    ),
                  ),
                )
              } else ...{
                GestureDetector(
                  onTap: () => removeImage(),
                  child: Container(
                    // padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xffffffff),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1a000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(
                            product.imageFile!,
                            fit: BoxFit.fill,
                            width: 103,
                            height: 103,
                          ),
                        ),
                        const Icon(
                          Icons.close,
                          color: Color(0xFFe04f5f),
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              },
              const SizedBox(
                height: 36,
              ),
              Form(
                key: _formKey,
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SimpleTextField(
                      onSaved: (v) => product.name = v!,
                      hintText: "Name",
                      label: "Name",
                      validationError:
                          Validator(rules: [RequiredRule(), MinLengthRule(4)]),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    /////////////////////////////
                    SimpleTextField(
                      onSaved: (v) => product.description = v!,
                      hintText: "Description",
                      label: "Description",
                      validationError:
                          Validator(rules: [RequiredRule(), MinLengthRule(20)]),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    /////////////////////////////
                    SimpleTextField(
                      onSaved: (v) => product.price = double.parse(v!),
                      hintText: "Price",
                      label: "Price",
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      validationError: Validator(rules: [
                        RequiredRule(),
                      ]),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    /////////////////////////////

                    SimpleTextField(
                        onSaved: (v) => product.priceForSale = double.parse(v!),
                        hintText: "optional",
                        label: "Sale price",
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        validationError: (String? salePrice) {
                          if (salePrice != null &&
                              double.parse(salePrice) >= product.price) {
                            return "sale price should be less than price";
                          }
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    /////////////////////////////
                    SimpleTextField(
                      onSaved: (v) => product.numberInStock = int.parse(v!),
                      hintText: "Product Stock",
                      label: "Product Stock",
                      validationError: Validator(rules: [
                        RequiredRule(),
                      ]),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                    ),
                  ],
                ),
              ),
              CustomButton(function: _submit, title: "Proceed")
            ],
          ),
        ),
      ),
    );
  }

  void openWithPopUp() {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Choose how to put photo"),
        content: Column(
          children: <Widget>[
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                    takeImage();
                  },
                  child: const Text("Camera"),
                  textColor: Colors.white,
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                    pickImage();
                  },
                  child: const Text("Gallery"),
                  textColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
