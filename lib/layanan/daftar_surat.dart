import 'package:flutter/material.dart';
import 'package:sipedes/data/theme/theme.dart';
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
        backgroundColor: AppColor.appbar,
        title: Text(
          'Jenis Surat',
          style: AppFont.duaempat.copyWith(color: AppColor.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0), // Menambahkan padding pada ListView
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(vertical: 4.0), // Menambahkan margin pada Card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text(
                'Surat Keterangan Domisili',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Domisili()));
              },
            ),
          ),
          Divider(),
          Card(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: Icon(Icons.money_off_outlined),
              title: Text(
                'Surat Keterangan Tidak Mampu (SKTM)',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Sktm()));
              },
            ),
          ),
          Divider(),
          Card(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: Icon(Icons.business_center_outlined),
              title: Text(
                'Surat Keterangan Usaha',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Usaha()));
              },
            ),
          ),
          Divider(),
          Card(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: Icon(Icons.person_outline),
              title: Text(
                'Surat Keterangan Belum Menikah',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BelumMenikah()));
              },
            ),
          ),
          Divider(),
          Card(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: Icon(Icons.map_outlined),
              title: Text(
                'Surat Keterangan Tanah',
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Tanah()));
              },
            ),
          ),
        ],
      ),
    );
  }
}