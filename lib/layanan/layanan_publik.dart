import 'package:flutter/material.dart';
import 'package:sipedes/layanan/tambah_surat.dart';
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _refreshSurat();
  }

  Future<void> _refreshSurat() async {
    setState(() {
      _isLoading = true;
      futureSurat = ApiService().fetchSuratByUserId(widget.idPengguna);
    });

    try {
      await futureSurat;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Pengajuan Surat"),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<List<Surat>>(
        future: futureSurat,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text(""));
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
                  subtitle: Text(
                      "Status: ${surat.status}\nTanggal: ${surat.tanggalPengajuan}"),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahSurat()),
          );
          if (result == true) {
            _refreshSurat();
          }
        },
        child: Icon(Icons.add),
        tooltip: "Tambah Surat",
      ),
    );
  }
}