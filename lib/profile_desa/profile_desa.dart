import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileDesa extends StatelessWidget {
  const ProfileDesa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Desa'),
      ),
      body: Center(
        child: Text("Halaman Profile Desa"),
      ),
    );
  }
}
