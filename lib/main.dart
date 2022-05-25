import 'package:fiction_update/provider/product/products_provider.dart';
import 'package:fiction_update/ui/screens/user_info_screen.dart';
import 'package:fiction_update/utils/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsProvider>(
          create: (_) => ProductsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Fiction Apps Task',
        theme: AppTheme().lightTheme,
        debugShowCheckedModeBanner: false,
        home: const UserInfoScreen(),
      ),
    );
  }
}
