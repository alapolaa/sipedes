import 'package:flutter/material.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/profile_desa/sejarah/sejarah.dart';
import 'package:sipedes/profile_desa/struktur_desa/struktur_desa.dart';
import 'package:sipedes/profile_desa/visimisi/visimisi.dart';

class ProfileDesa extends StatelessWidget {
  const ProfileDesa({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Profile Desa',
            style: AppFont.duaempat.copyWith(
              color: AppColor.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColor.appbar,
          bottom: const TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.grey,
            tabs: [
              Tab(text: 'Sejarah'),
              Tab(text: 'Visi Misi'),
              Tab(text: 'Struktur Desa'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const SejarahView(),
            const VisiMisiView(),
            StrukturDesaView(),
          ],
        ),
      ),
    );
  }
}
