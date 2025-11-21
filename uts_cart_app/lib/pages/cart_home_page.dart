// lib/pages/cart_home_page.dart (Final Code)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart'; 
import '../blocs/cart_cubit.dart';
import '../widgets/product_card.dart';
import 'cart_summary_page.dart';

class CartHomePage extends StatelessWidget {
  const CartHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data produk
    final products = ProductModel.dummyProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Produk'),
        actions: [
          // BlocBuilder untuk menampilkan total item secara real-time di AppBar
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              // --- PERBAIKAN DI SINI ---
              // Akses Cubit menggunakan context.read() hanya sekali di luar builder,
              // atau, lebih aman, ambil nilai totalItems langsung dari getter Cubit.
              // Karena BlocBuilder sudah memicu rebuild, ini akan bekerja.
              final cartCubit = context.read<CartCubit>();
              final totalItems = cartCubit.totalItems; 
              // -------------------------

              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartSummaryPage()),
                      );
                    },
                  ),
                  if (totalItems > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Text(
                          totalItems.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7, // Sesuaikan rasio untuk ProductCard
        ),
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}