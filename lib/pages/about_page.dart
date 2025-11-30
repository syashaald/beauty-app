// lib/pages/about_page.dart
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About'), backgroundColor: Colors.white, elevation: 1, foregroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('Luminance — Beauty Product Catalog', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('Versi: 1.0.0'),
          SizedBox(height: 12),
          Text('Deskripsi:', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 6),
          Text('Aplikasi katalog produk kecantikan sederhana untuk kebutuhan praktikum. Menampilkan daftar produk, detail, kategori, dan favorites.'),
          SizedBox(height: 12),
          Text('Dibuat oleh:', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 6),
          Text('Syasha Chikal Aldila	'),
        ]),
      ),
    );
  }
}
