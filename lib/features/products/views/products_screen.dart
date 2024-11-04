import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.model.dart';
import '../providers/product.provider.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    // Escuchar productos en tiempo real
    productProvider.listenToProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navegar a la pantalla para agregar un nuevo producto
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddProductScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          if (productProvider.products.isEmpty) {
            return const Center(child: Text('No hay productos registrados'));
          }

          return ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
              final product = productProvider.products[index];
              return ListTile(
                leading: SizedBox(
                  width: 50.0, // Define un tamaño para la imagen
                  height: 50.0,
                  child: product.fotoUrl.isNotEmpty
                      ? Image.network(product.fotoUrl, fit: BoxFit.cover)
                      : const Icon(Icons.image), // Ícono si no hay imagen
                ),
                title: Text(product.nombre),
                subtitle: Text('Nro. Serie: ${product.numeroSerie}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Navegar a la pantalla para editar el producto
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditProductScreen(product: product),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        productProvider.deleteProduct(product.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
