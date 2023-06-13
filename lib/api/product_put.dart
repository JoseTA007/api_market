import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'products.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;
  final Function(Product) onUpdate;

  const EditProductScreen({
    Key? key,
    required this.product,
    required this.onUpdate,
  }) : super(key: key);

  @override
  EditProductScreenState createState() => EditProductScreenState();
}

class EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController titleController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.product.title);
    priceController =
        TextEditingController(text: widget.product.price.toString());
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void saveChanges() {
    final updatedProduct = Product(
      id: widget.product.id,
      title: titleController.text,
      price: double.parse(priceController.text),
      imageUrl: widget.product.imageUrl,
    );

    widget.onUpdate(updatedProduct);

    Navigator.popAndPushNamed(context, '/product_details',
        arguments: updatedProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Editar Producto',
            style: GoogleFonts.bangers(
              color: Colors.amber.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        margin: const EdgeInsets.all(50),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget.product.imageUrl,
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 16),
              Text('ID: ${widget.product.id}'),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Título'),
                controller: titleController,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Precio'),
                controller: priceController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: saveChanges,
                child: const Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
