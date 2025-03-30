import 'package:flutter/material.dart';
import 'package:sipedes/layanan/belum_menikah.dart';
import 'package:sipedes/layanan/domisili.dart';
import 'package:sipedes/layanan/sktm.dart';
import 'package:sipedes/layanan/tanah.dart';
import 'package:sipedes/layanan/usaha.dart';

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

              Navigator.push(context, MaterialPageRoute(builder: (context)=>Domisili()));
            },
          ),
          ListTile(
            title: Text('Surat Keterangan Tidak Mampu (SKTM)'),
            onTap: () {
              // Navigasi ke halaman tambah SKTM
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Sktm()));
            },
          ),
          ListTile(
            title: Text('Surat Keterangan Usaha'),
            onTap: () {
              // Navigasi ke halaman tambah surat usaha
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Usaha()));
            },
          ),
          ListTile(
            title: Text('Surat Keterangan Belum Menikah'),
            onTap: () {
              // Navigasi ke halaman tambah surat usaha
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BelumMenikah()));
            },
          ),
          ListTile(
            title: Text('Surat Keterangan Tanah'),
            onTap: () {
              // Navigasi ke halaman tambah surat usaha
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Tanah()));
            },
          ),
          // Tambahkan jenis surat lainnya di sini
        ],
      ),
    );
  }
}