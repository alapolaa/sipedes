import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id_user');

    if (userId == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(Uri.parse('http://192.168.20.202/slampang/api/profile/profile.php?id_user=$userId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = json.decode(response.body);
        if (result['status'] == 'success') {
          setState(() {
            userData = result['data'];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch profile data.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userData == null
          ? Center(child: Text('User data not found'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${userData!['nama']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('NIK: ${userData!['nik']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Tanggal Lahir: ${userData!['tanggal_lahir']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Alamat: ${userData!['alamat']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('No HP: ${userData!['no_hp']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Email: ${userData!['email']}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}