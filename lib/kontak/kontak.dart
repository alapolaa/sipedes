import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Kontak extends StatelessWidget {
  const Kontak({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kontak '),
      ),
      body: Center(
        child: Text("Halaman Kontak "),
      ),
    );
  }
}
