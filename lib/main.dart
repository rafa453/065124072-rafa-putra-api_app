import 'package:flutter/material.dart';
import 'pages/product_list_page.dart';

void main() {
  runApp(const KatalogProdukApp());
}

class KatalogProdukApp extends StatelessWidget {
  const KatalogProdukApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Produk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductListPage(),
    );
  }
}
