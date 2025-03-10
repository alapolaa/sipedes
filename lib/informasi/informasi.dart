import 'package:flutter/material.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/informasi/berita/berita.dart';
import 'package:sipedes/informasi/pengumuman/pengumuman.dart';
import 'package:sipedes/profile_desa/struktur_desa/struktur_desa.dart';
import 'package:sipedes/profile_desa/visimisi/visimisi.dart';

import 'kegiatan/kegiatan.dart';

class InformasiDesa extends StatelessWidget {
  const InformasiDesa({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Informasi Desa',
            style: AppFont.duapuluhbold.copyWith(
              color: AppColor.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColor.appbar,
          bottom: const TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.grey,
            tabs: [
              Tab(text: 'Berita'),
              Tab(text: 'Kegiatan'),
              Tab(text: 'Pengumuman'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
             Berita(),
             Kegiatan(),
            Pengumuman(),
          ],
        ),
      ),
    );
  }
}
