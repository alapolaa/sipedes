import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/informasi/informasi.dart';
import 'package:sipedes/kontak/kontak.dart';
import 'package:sipedes/layanan/layanan_publik.dart';
import 'package:sipedes/profile_desa/profile_desa.dart';
import '../home/home.dart';
import '../profile/profile.dart';

class MenuNavbar extends StatefulWidget {
  final int initialIndex;

  MenuNavbar({this.initialIndex = 0}); // Default ke indeks 0 (HomeScreen)

  @override
  _MenuNavbarState createState() => _MenuNavbarState();
}

class _MenuNavbarState extends State<MenuNavbar> {
  int _selectedIndex = 0;
  int? _idUser;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _selectedIndex = widget.initialIndex;
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _idUser = prefs.getInt('id_user');
    });
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      ProfileDesa(),
      InformasiDesa(),
      _idUser != null
          ? SuratScreen(idPengguna: _idUser.toString())
          : Center(child: CircularProgressIndicator()),
      KontakForm(),
      ProfilePage(),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.location_city), label: 'Profile Desa'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Informasi Desa'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Layanan Publik'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone), label: 'Kontak'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.sukses,
        unselectedItemColor: AppColor.batal,
        onTap: _onItemTapped,
      ),
    );
  }
}