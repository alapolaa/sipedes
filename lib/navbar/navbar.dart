import 'package:flutter/material.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/informasi/informasi.dart';
import 'package:sipedes/kontak/kontak.dart';
import 'package:sipedes/layanan/layanan_publik.dart';
import 'package:sipedes/profile_desa/profile_desa.dart';

import '../data/model/kontak.dart';
import '../home/home.dart';
import '../profile/profile.dart';
import '../tak.dart';

class MenuNavbar extends StatefulWidget {
  @override
  _MenuNavbarState createState() => _MenuNavbarState();
}

class _MenuNavbarState extends State<MenuNavbar> {
  int _selectedIndex = 0;

  List<Widget> _buildScreens() {
    return [
      Center(child: HomeScreen()),
      Center(child: ProfileDesa()),
      Center(child: InformasiDesa()),
      Center(child: LayananPublik()),
      Center(child: KontakForm()),
      Center(child: Profile()),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.location_city), label: 'Profile Desa'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Informasi Desa'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Layanan Publik'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: 'Kontak'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.sukses,
        unselectedItemColor: AppColor.batal,
        onTap: _onItemTapped,
      ),
    );
  }
}