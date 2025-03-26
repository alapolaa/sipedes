import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../navbar/navbar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nikController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  bool isLoading = false;

  Future<void> _login() async {
    String nik = nikController.text.trim();
    String tanggalLahir = tanggalLahirController.text.trim();

    if (nik.isEmpty || tanggalLahir.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("NIK dan Tanggal Lahir wajib diisi!")),
      );
      return;
    }

    DateTime? parsedDate = DateTime.tryParse(tanggalLahir);
    if (parsedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Format Tanggal Lahir salah! Gunakan YYYY-MM-DD")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse("http://192.168.20.202/slampang/api/login.php"),
        body: {"nik": nik, "tanggal_lahir": tanggalLahir},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setInt('id_user', data['data']['id']); // Simpan ID pengguna
          await prefs.setString('nik', nik);
          await prefs.setString('nama', data['data']['nama']);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MenuNavbar()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal menghubungi server!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nikController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "NIK",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: tanggalLahirController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: "Tanggal Lahir (YYYY-MM-DD)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : _login,
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}