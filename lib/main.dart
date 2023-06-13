import 'package:api_2/api/product_details.dart';
import 'package:api_2/api/products.dart';
import 'package:api_2/screen/main_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: '/screen_page',
      routes: {
        '/screen_page': (context) => const MainScreen(),
        '/product_details': (context) {
          final product = ModalRoute.of(context)?.settings.arguments as Product;
          return ProductDetailsScreen(
            product: product,
            deleteProduct: deleteProduct, // Pass the deleteProduct method here
            navigateToEditProductScreen:
                navigateToEditProductScreen, // Pass the navigateToEditProductScreen method here
          );
        },
      },
    );
  }

  void deleteProduct(int id) {
    // Implement the deleteProduct method here
  }

  void navigateToEditProductScreen(Product product) {
    // Implement the navigateToEditProductScreen method here
  }
}
