// Di dalam lib/widgets/product_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart'; 
import '../blocs/cart_cubit.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    // Akses Cubit menggunakan context.read() karena ini adalah event (button press)
    final cartCubit = context.read<CartCubit>();

    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Gambar produk
          Expanded(
            child: Image.network(
              product.image, // Menggunakan URL image dari Model
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 50),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama Produk
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Harga Produk
                Text(
                  'Rp ${product.price.toStringAsFixed(0)}',
                  style: const TextStyle(color: Colors.green),
                ),
                const SizedBox(height: 8),
                
                // Tombol "Tambah ke Keranjang"
                ElevatedButton.icon(
                  icon: const Icon(Icons.add_shopping_cart, size: 18),
                  label: const Text('Add'),
                  onPressed: () {
                    cartCubit.addToCart(product); // Panggil fungsi Cubit
                    // Tampilkan notifikasi
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} ditambahkan!')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}