import 'package:flutter/material.dart';
import '../data/api_service/test.dart';
import '../data/model/surat.dart';


class SuratScreen extends StatefulWidget {
  final String idPengguna;

  const SuratScreen({super.key, required this.idPengguna});

  @override
  _SuratScreenState createState() => _SuratScreenState();
}

class _SuratScreenState extends State<SuratScreen> {
  late Future<List<Surat>> futureSurat;

  @override
  void initState() {
    super.initState();
    futureSurat = ApiService().fetchSuratByUserId(widget.idPengguna);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Pengajuan Surat")),
      body: FutureBuilder<List<Surat>>(
        future: futureSurat,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada data surat"));
          }

          final suratList = snapshot.data!;
          return ListView.builder(
            itemCount: suratList.length,
            itemBuilder: (context, index) {
              final surat = suratList[index];
              return Card(
                child: ListTile(
                  title: Text(surat.jenisSurat),
                  subtitle: Text("Status: ${surat.status}\nTanggal: ${surat.tanggalPengajuan}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
