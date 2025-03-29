import 'package:flutter/material.dart';
import 'package:sipedes/layanan/tambah_surat.dart';

class DaftarSurat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Jenis Surat'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Surat Keterangan Domisili'),
            onTap: () {

              Navigator.push(context, MaterialPageRoute(builder: (context)=>TambahSurat()));
            },
          ),
          ListTile(
            title: Text('Surat Keterangan Tidak Mampu (SKTM)'),
            onTap: () {
              // Navigasi ke halaman tambah SKTM
              Navigator.pop(context, true);
            },
          ),
          ListTile(
            title: Text('Surat Keterangan Usaha'),
            onTap: () {
              // Navigasi ke halaman tambah surat usaha
              Navigator.pop(context, true);
            },
          ),
          // Tambahkan jenis surat lainnya di sini
        ],
      ),
    );
  }
}