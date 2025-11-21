import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import Cubit dan Halaman Utama Anda
import 'blocs/cart_cubit.dart';
import 'pages/cart_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Widget ini adalah root dari aplikasi Anda.
  @override
  Widget build(BuildContext context) {
    // 1. PROVIDE CUBIT
    // Menggunakan BlocProvider untuk menyediakan instance CartCubit
    // ke seluruh pohon widget (sehingga CartHomePage dan CartSummaryPage dapat mengaksesnya).
    return BlocProvider(
      create: (context) => CartCubit(),
      child: MaterialApp(
        title: 'Aplikasi Kasir Mobile',
        // Menggunakan tema sederhana yang sesuai dengan aplikasi kasir
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          useMaterial3: true,
        ),
        // 2. SET HOME PAGE
        // Halaman utama aplikasi adalah CartHomePage, tempat katalog berada.
        home: const CartHomePage(),
      ),
    );
  }
}

// Catatan: Semua kelas seperti 'MyHomePage', '_MyHomePageState', dll.
// yang terkait dengan Flutter Demo counter telah dihapus karena tidak relevan
// dengan kebutuhan ujian Anda.