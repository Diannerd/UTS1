// Di dalam lib/pages/cart_summary_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_cubit.dart';
import '../models/product_model.dart'; 

class CartSummaryPage extends StatelessWidget {
  const CartSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Akses Cubit menggunakan context.read() karena kita tidak perlu rebuild widget ini
    // Tetapi kita perlu Cubit instance untuk memanggil fungsi updateQuantity dan clearCart
    final cartCubit = context.read<CartCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Keranjang'),
      ),
      // BlocBuilder untuk memantau state keranjang dan memicu rebuild
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.isEmpty) {
            return const Center(child: Text('Keranjang Anda kosong.'));
          }

          final cartItems = state.entries.toList();

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    final product = item.key;
                    final currentQuantity = item.value;

                    // --- BAGIAN INI TELAH DIGANTI UNTUK BONUS POIN (Tombol +/-) ---
                    return ListTile(
                      leading: Image.network(
                        product.image, 
                        width: 50, 
                        height: 50, 
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 50),
                      ),
                      title: Text(product.name),
                      subtitle: Text('Harga: Rp ${product.price.toStringAsFixed(0)}'),
                      
                      // Kontrol Kuantitas (Bonus Poin)
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Tombol Minus (-)
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              // Panggil updateQuantity: mengurangi kuantitas. 
                              // Jika hasil < 1, Cubit akan menghapusnya.
                              cartCubit.updateQuantity(product, currentQuantity - 1);
                            },
                          ),
                          
                          // Tampilan Kuantitas
                          Text('$currentQuantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          
                          // Tombol Plus (+)
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              // Menambah kuantitas
                              cartCubit.updateQuantity(product, currentQuantity + 1);
                            },
                          ),
                        ],
                      ),
                    );
                    // --- AKHIR BAGIAN YANG DIGANTI ---
                  },
                ),
              ),

              // Bagian Total dan Tombol Checkout
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Total Item
                    // Mengakses getter pada cartCubit yang sudah diinisialisasi
                    Text(
                      'Total Item: ${cartCubit.totalItems}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    // Total Harga (Real-time)
                    Text(
                      'Total Harga: Rp ${cartCubit.totalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    const SizedBox(height: 16),
                    
                    // Tombol Checkout / Clear Cart
                    ElevatedButton(
                      onPressed: () {
                        cartCubit.clearCart();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Checkout berhasil! Keranjang dikosongkan.')),
                        );
                        Navigator.pop(context); // Kembali ke halaman utama
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Checkout (Clear Cart)', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}