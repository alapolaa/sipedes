import 'package:flutter/material.dart';
import 'data/api_service/test.dart';
import 'data/model/surat.dart';

class SuratScreen extends StatefulWidget {
  @override
  _SuratScreenState createState() => _SuratScreenState();
}

class _SuratScreenState extends State<SuratScreen> {
  final ApiService apiService = ApiService();
  List<Surat> suratList = [];
  bool isLoading = true;
  String sessionId = '33c9d1d4f89bbc4c7d31270bfb51ccef'; // Sesuaikan dengan PHPSESSID yang didapat

  @override
  void initState() {
    super.initState();
    fetchSurat();
  }

  Future<void> fetchSurat() async {
    try {
      List<Surat> data = await apiService.fetchSurat(sessionId);
      setState(() {
        suratList = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pengajuan Surat")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : suratList.isEmpty
          ? Center(child: Text("Tidak ada data surat"))
          : ListView.builder(
        itemCount: suratList.length,
        itemBuilder: (context, index) {
          final surat = suratList[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(surat.jenisSurat),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Status: ${surat.status}"),
                  Text("Tanggal Pengajuan: ${surat.tanggalPengajuan}"),
                  Text("Tanggal Selesai: ${surat.tanggalSelesai}"),
                  if (surat.status == "Ditolak")
                    Text("Alasan: ${surat.alasanPenolakan}", style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
