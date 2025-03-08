import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformasiDesa extends StatelessWidget {
  const InformasiDesa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('InformasiDesa '),
      ),
      body: Center(
        child: Text("Halaman InformasiDesa "),
      ),
    );
  }
}
