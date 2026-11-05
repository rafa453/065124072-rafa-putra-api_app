import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../widgets/error_view.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ApiService _apiService = ApiService();
  late Future<Product> _futureProduct;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  void _loadProduct() {
    setState(() {
      _futureProduct = _apiService.fetchProduct(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: FutureBuilder<Product>(
        future: _futureProduct,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return ErrorView(
              message: snapshot.error.toString(),
              onRetry: _loadProduct,
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Tidak ada data.'));
          }

          final product = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 240,
                  color: Colors.grey.shade300,
                  child: Image.network(
                    product.thumbnail,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(
                      height: 240,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 48),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(label: 'Merk', value: product.brand ?? '-'),
                      _InfoRow(label: 'Kategori', value: product.category),
                      _InfoRow(
                          label: 'Harga',
                          value: 'Rp${(product.price * 15000).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
                      _InfoRow(label: 'Rating', value: product.rating.toString()),
                      const SizedBox(height: 12),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
