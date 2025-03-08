import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/home/home.dart';
import 'package:sipedes/informasi/informasi.dart';

import 'package:sipedes/kontak/kontak.dart';
import 'package:sipedes/layanan/layanan_publik.dart';
import 'package:sipedes/profile/profile.dart';
import 'package:sipedes/profile_desa/profile_desa.dart';

class MenuNavbar extends StatefulWidget {
  const MenuNavbar({super.key});

  @override
  _MenuNavbarState createState() => _MenuNavbarState();
}

class _MenuNavbarState extends State<MenuNavbar> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      Center(child: HomeScreen()),
      Center(child: ProfileDesa()),
      Center(child: InformasiDesa()),
      Center(child: LayananPublik()),
      Center(child: Kontak()),
      Center(child: Profile()),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      _buildNavItem(Icons.home, "Home"),
      _buildNavItem(Icons.account_balance, "Profile Desa"),
      _buildNavItem(Icons.info, "Informasi"),
      _buildNavItem(Icons.public, "Layanan"),
      _buildNavItem(Icons.contact_mail, "Kontak"),
      _buildNavItem(Icons.person, "Profil"),
    ];
  }

  PersistentBottomNavBarItem _buildNavItem(IconData icon, String title) {
    return PersistentBottomNavBarItem(
      icon: Icon(icon),
      title: title,
      activeColorPrimary: AppColor.sukses,
      inactiveColorPrimary: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: 60,
        navBarStyle: NavBarStyle.style13,
      ),
    );
  }
}
