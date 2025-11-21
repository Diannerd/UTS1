// lib/blocs/cart_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';

// State: Map yang memetakan ProductModel ke kuantitasnya (int)
typedef CartState = Map<ProductModel, int>;

class CartCubit extends Cubit<CartState> {
  CartCubit() : super({});

  // Fungsi: Mengosongkan keranjang (HARUS ADA DI DALAM CLASS)
  void clearCart() {
    emit({}); // Mengembalikan state ke Map kosong
  }

  // Fungsi: Menambah produk
  void addToCart(ProductModel product) {
    final newState = Map<ProductModel, int>.from(state);

    // Cek apakah produk sudah ada di keranjang berdasarkan ID
    final existingEntry = newState.entries.firstWhere(
        (entry) => entry.key.id == product.id,
        orElse: () => MapEntry(product, 0));

    // Ambil product key yang sudah ada (jika ada) untuk menghindari duplikasi key
    final existingProductKey = existingEntry.key;
    final currentQuantity = existingEntry.value;

    // Jika produk sudah ada, hapus entri lama
    if (currentQuantity > 0) {
      newState.remove(existingProductKey);
    }

    // Update/Tambahkan entri baru dengan product (key) yang benar dan kuantitas + 1
    newState[product] = currentQuantity + 1;

    emit(newState);
  }

  // Fungsi: Menghapus produk (menghapus sepenuhnya dari keranjang)
  void removeFromCart(ProductModel product) {
    final newState = Map<ProductModel, int>.from(state);

    // Cari kunci (ProductModel) yang sesuai di map berdasarkan ID
    final productKeyToRemove = newState.keys.firstWhere(
        (p) => p.id == product.id,
        orElse: () => product);
    
    newState.remove(productKeyToRemove);
    emit(newState);
  }

  // Fungsi: Mengubah jumlah kuantitas produk
  void updateQuantity(ProductModel product, int qty) {
    if (qty < 0) return;

    final newState = Map<ProductModel, int>.from(state);

    // Cari entri yang sudah ada berdasarkan ID
    final existingEntry = newState.entries.firstWhere(
        (entry) => entry.key.id == product.id,
        orElse: () => MapEntry(product, 0));

    final existingProductKey = existingEntry.key;

    // Hapus entri lama
    if (existingEntry.value > 0) {
      newState.remove(existingProductKey);
    }
    
    if (qty == 0) {
      // Tidak perlu ditambah, sudah dihapus di atas
    } else {
      // Tambahkan/perbarui dengan product (key) yang baru dan kuantitas baru
      newState[product] = qty;
    }
    
    emit(newState);
  }

  // Fungsi: Menghitung total item (getter)
  int get totalItems {
    return state.values.fold(0, (sum, quantity) => sum + quantity);
  }

  // Fungsi: Menghitung total harga (getter)
  double get totalPrice {
    double total = 0.0;
    state.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }
}