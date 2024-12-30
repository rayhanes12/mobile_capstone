import 'package:flutter/material.dart';
import 'package:projek_capstone7/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.namaBarang),
        backgroundColor: Color(0xFF69BF5E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar produk
              Image.network(
                'http://192.168.1.25:5000/static/profile_photos/${product.gambar}',
                fit: BoxFit.cover,
                height: 300,
              ),
              SizedBox(height: 20),
              
              // Nama Produk
              Text(
                product.namaBarang,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              
              // Harga Produk
              Text(
                'Rp ${product.harga}',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),

              // Deskripsi Produk
              Text(
                'Deskripsi: ${product.deskripsi}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 10),

              // Stok Produk
              Text(
                'Stok: ${product.stok} items available',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 10),

              // Nama Toko (misal untuk detail user_id atau hubungan lainnya)
              Text(
                'Toko: ${product.userId}', // Misalkan hanya menampilkan userId untuk sekarang
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
