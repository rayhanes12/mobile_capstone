class Product {
  final int id;
  final String namaBarang;
  final int harga;
  final String kategori;
  final int stok;
  final String deskripsi;
  final String gambar;
  final int userId;

  Product({
    required this.id,
    required this.namaBarang,
    required this.harga,
    required this.kategori,
    required this.stok,
    required this.deskripsi,
    required this.gambar,
    required this.userId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      namaBarang: json['nama_barang'],
      harga: json['harga'],
      kategori: json['kategori'],
      stok: json['stok'],
      deskripsi: json['deskripsi'],
      gambar: json['gambar'],
      userId: json['user_id'],
    );
  }
}
