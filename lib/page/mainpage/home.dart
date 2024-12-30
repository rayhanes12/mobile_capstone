import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projek_capstone7/models/product.dart';

import 'dart:convert';

import 'package:projek_capstone7/page/mainpage/productdetailscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // Mengambil data produk dari API
  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/api/products'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['products'];
      setState(() {
        _products = jsonResponse.map((product) => Product.fromJson(product)).toList();
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(70.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFA2E555), Color(0xFF69BF5E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Motto
                  Expanded(
                    child: Text(
                      "Kulak Sembako\nMudah, Cepat, dan\nTerpercaya",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'merriwaether',
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/login_image.png',
                    height: 100,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Bagian Produk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Our Product",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Grid Produk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true, 
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman detail produk saat produk diklik
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(product: _products[index]),
                        ),
                      );
                    },
                    child: ProductCard(product: _products[index]),
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

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'http://192.168.1.25:5000/static/profile_photos/${product.gambar}',
            height: 100,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.namaBarang,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Rp ${product.harga}',
              style: TextStyle(color: Colors.green, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
