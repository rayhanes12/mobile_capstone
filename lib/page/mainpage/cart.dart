// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CartPage(),
//     );
//   }
// }

// class CartPage extends StatelessWidget {
//   final List<Map<String, dynamic>> cartItems = [
//     {
//       'image': null,
//       'name': 'Tepung Segitiga Biru',
//       'price': 'Rp. 62.000',
//       'quantity': 1,
//     },
//     {
//       'image': null, 
//       'name': 'Minyak Bimoli',
//       'price': 'Rp. 42.000',
//       'quantity': 2,
//     },
//     {
//       'image': null, 
//       'name': 'Teh 2 Tang',
//       'price': 'Rp. 15.000',
//       'quantity': 3,
//     },
//     {
//       'image': null, 
//       'name': 'Gulaku',
//       'price': 'Rp. 36.000',
//       'quantity': 2,
//     },
//     {
//       'image': null, 
//       'name': 'Minyak Filma',
//       'price': 'Rp. 40.000',
//       'quantity': 2,
//     },
//     {
//       'image': null, 
//       'name': 'Teh Tong Ji',
//       'price': 'Rp. 12.000',
//       'quantity': 2,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Cart',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.green,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//           final item = cartItems[index];
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 8.0),
//             child: Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Container(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // Placeholder untuk gambar produk
//                     Container(
//                       height: 50,
//                       width: 50,
//                       color: Colors.grey[300],
//                       child: item['image'] != null
//                           ? Image.asset(item['image'], fit: BoxFit.cover)
//                           : Icon(Icons.image, color: Colors.grey),
//                     ),
//                     const SizedBox(width: 16),
//                     // Informasi produk
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             item['name'],
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             item['price'],
//                             style: TextStyle(
//                               color: Colors.green,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Jumlah item
//                     Text(
//                       '${item['quantity']}x',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CartPage(),
//     );
//   }
// }

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [
    {
      'image': null,
      'name': 'Tepung Segitiga Biru',
      'price': 62000,
      'quantity': 1,
    },
    {
      'image': null,
      'name': 'Minyak Bimoli',
      'price': 42000,
      'quantity': 2,
    },
    {
      'image': null,
      'name': 'Teh 2 Tang',
      'price': 15000,
      'quantity': 3,
    },
    {
      'image': null,
      'name': 'Gulaku',
      'price': 36000,
      'quantity': 2,
    },
    {
      'image': null,
      'name': 'Minyak Filma',
      'price': 40000,
      'quantity': 2,
    },
    {
      'image': null,
      'name': 'Teh Tong Ji',
      'price': 12000,
      'quantity': 2,
    },
  ];

int getTotalPrice() {
  return cartItems.fold(0, (total, item) {
    // Konversi 'price' dari String ke int
    int price = item['price'];

    // Konversi 'quantity' ke int jika diperlukan
    int quantity = item['quantity'] is int
        ? item['quantity']
        : int.tryParse(item['quantity'].toString()) ?? 0;

    // Hitung total
    return total + (price * quantity);
  });
}


  // Fungsi untuk menghapus item
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Placeholder untuk gambar produk
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: item['image'] != null
                                ? Image.asset(item['image'], fit: BoxFit.cover)
                                : Icon(Icons.image, color: Colors.grey),
                          ),
                          const SizedBox(width: 16),
                          // Informasi produk
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Rp. ${item['price'].toString()}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Jumlah item
                          Column(
                            children: [
                              Text(
                                '${item['quantity']}x',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => removeItem(index),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Footer dengan total dan tombol checkout
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Harga:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Rp. ${getTotalPrice()}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan fungsi checkout di sini
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Center(
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
