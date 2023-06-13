import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'products.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final Function(int) deleteProduct;
  final Function(Product) navigateToEditProductScreen;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
    required this.deleteProduct,
    required this.navigateToEditProductScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      appBar: AppBar(
        title: Text(
          'Detalles del Producto',
          style: GoogleFonts.bangers(
            color: Colors.amber.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: Colors.red.shade400),
          margin: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                product.imageUrl,
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 16),
              Text('ID: ${product.id}'),
              const SizedBox(height: 16),
              Text('Título: ${product.title}'),
              const SizedBox(height: 16),
              Text('Precio: \$${product.price.toStringAsFixed(2)}'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      deleteProduct(product.id);
                      Navigator.of(context).pop();
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Eliminar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      navigateToEditProductScreen(product);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Editar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
