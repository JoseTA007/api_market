import 'package:api_2/api/product_details.dart';
import 'package:api_2/api/product_put.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:api_2/api/metodos_api.dart';
import 'package:api_2/api/products.dart';

void main() => runApp(const MainScreen());

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? searchId;
  List<Product> products = [];
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final List<Product> fetchedProducts = await ApiService.fetchProducts();
      setState(() {
        products = fetchedProducts;
        filteredProducts = fetchedProducts;
      });
    } catch (e) {
      throw Exception('Error: ');
    }
  }

  void filterProducts(int id) {
    setState(() {
      searchId = id;
      filteredProducts = products.where((product) => product.id == id).toList();
    });
  }

  Future<void> deleteProduct(int id) async {
    try {
      await ApiService.deleteProduct(id);
      setState(() {
        products.removeWhere((product) => product.id == id);
        filteredProducts.removeWhere((product) => product.id == id);
      });
    } catch (e) {
      throw Exception('Error:');
    }
  }

  void updateProduct(Product product) {
    setState(() {
      final index = products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        products[index] = product;
        filteredProducts = List.from(products);
      }
    });
  }

  void navigateToEditProductScreen(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(
          product: product,
          onUpdate: updateProduct,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.green.shade900,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              'MARKETPLACE',
              style: GoogleFonts.bangers(
                color: Colors.amber.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: Colors.red.shade900, width: 2)),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Buscar por ID',
                    hintStyle: TextStyle(
                      color: Colors.blue,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      final int id = int.parse(value);
                      filterProducts(id);
                    } else {
                      setState(() {
                        filteredProducts = products;
                      });
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            product: product,
                            deleteProduct: deleteProduct,
                            navigateToEditProductScreen:
                                navigateToEditProductScreen,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.red.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.white, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              product.imageUrl,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Id: ${product.id.toString()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Confirm Deletion'),
                                      content: const Text(
                                          'Are you sure you want to delete this product?'),
                                      actions: [
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Delete'),
                                          onPressed: () {
                                            deleteProduct(product.id);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  navigateToEditProductScreen(product);
                                },
                              ),
                            ],
                          ),*/
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
