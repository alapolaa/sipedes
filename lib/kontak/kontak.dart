import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';
import '../data/api_service/api_service.dart';
import '../footer.dart';
import 'notif.dart';


class KontakForm extends StatefulWidget {
  @override
  _KontakFormState createState() => _KontakFormState();
}

class _KontakFormState extends State<KontakForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjekController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;
  String _responseMessage = '';
  final ApiService _apiService = ApiService();

  Future<void> _kirimPesan() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _responseMessage = '';
      });

      try {
        final responseData = await _apiService.kirimPesan(
          _nameController.text,
          _emailController.text,
          _subjekController.text,
          _messageController.text,
        );

        setState(() {
          _isLoading = false;
          _responseMessage = responseData['message'];
        });

        if (responseData['status'] == 'success') {
          _showSuccessDialog(context, responseData['message']);
        } else {
          _showErrorDialog(context, responseData['message']);
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
          _responseMessage = 'Terjadi kesalahan: $error';
        });
        _showErrorDialog(context, 'Terjadi kesalahan: $error');
      }
    }
  }

  void _showSuccessDialog(BuildContext context, String message) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PesanTerkirim()),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PesanError(message: message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.appbar,
        title: Text('Kontak',
            style: AppFont.duaempat.copyWith(color: AppColor.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              'Jika Anda memiliki saran, kritik, atau masukan terkait Desa Larangan Slampar, '
                  'silakan sampaikan melalui kontak resmi desa. Masukan Anda sangat berarti untuk '
                  'mendukung pengembangan dan kemajuan desa secara bersama-sama.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: Colors.black87),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimen.h20, vertical: AppDimen.w20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan nama Anda';
                        }
                        return null;
                      },
                    ),
                    10.0.height,
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan email Anda';
                        }
                        return null;
                      },
                    ),
                    10.0.height,
                    TextFormField(
                      controller: _subjekController,
                      decoration: InputDecoration(
                        labelText: 'Subjek',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan subjek pesan';
                        }
                        return null;
                      },
                    ),
                    10.0.height,
                    TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        labelText: 'Pesan',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan pesan Anda';
                        }
                        return null;
                      },
                    ),
                    20.0.height,
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _kirimPesan,
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Text(
                          'Kirim Pesan',
                          style: AppFont.empatbelas
                              .copyWith(color: AppColor.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.sukses,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                        ),
                      ),
                    ),
                    10.0.height,
                    Text(
                      _responseMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            50.0.height,
            FooterScreen()
          ],
        ),
      ),
    );
  }
}
