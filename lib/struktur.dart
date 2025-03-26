import 'package:flutter/material.dart';
import 'data/api_service/api_service.dart';
import 'data/model/kegiatan.dart';
import 'footer.dart';

class KegiatanPage extends StatefulWidget {
  @override
  _KegiatanPageState createState() => _KegiatanPageState();
}

class _KegiatanPageState extends State<KegiatanPage> {
  late Future<List<KegiatanModel>> _kegiatanList;

  @override
  void initState() {
    super.initState();
    _kegiatanList = ApiService().fetchKegiatan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Kegiatan Desa",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Menyajikan informasi terbaru tentang peristiwa dan kegiatan terkini dari desa.',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            FutureBuilder<List<KegiatanModel>>(
              future: _kegiatanList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Terjadi kesalahan!'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Tidak ada kegiatan tersedia'));
                }

                final kegiatan = snapshot.data!;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    showCheckboxColumn: false,
                    columnSpacing: 10,
                    columns: [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Gambar')),
                      DataColumn(label: Text('Kegiatan')),
                      DataColumn(label: Text('Keterangan')),
                      DataColumn(label: Text('Tanggal Mulai')),
                      DataColumn(label: Text('Tanggal Selesai')),
                      DataColumn(label: Text('Lokasi')),
                    ],
                    rows: kegiatan
                        .asMap()
                        .entries
                        .map(
                          (entry) => DataRow(
                        onSelectChanged: (selected) {
                          if (selected != null && selected) {
                            _showDetailDialog(entry.value);
                          }
                        },
                        cells: [
                          DataCell(Text((entry.key + 1).toString())),
                          DataCell(
                            Image.network(
                              "${ApiService.baseUrl}/${entry.value.gambar}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.broken_image, size: 50);
                              },
                            ),
                          ),
                          DataCell(Text(entry.value.namaKegiatan)),
                          DataCell(Text(
                            entry.value.keterangan.length > 50
                                ? '${entry.value.keterangan.substring(0, 20)}...'
                                : entry.value.keterangan,
                          )),
                          DataCell(Text(entry.value.tanggalMulai)),
                          DataCell(Text(entry.value.tanggalSelesai)),
                          DataCell(Text(entry.value.lokasi)),
                        ],
                      ),
                    )
                        .toList(),
                  ),
                );
              },
            ),
            SizedBox(height: 100),
            FooterScreen(),
          ],
        ),
      ),
    );
  }

  void _showDetailDialog(KegiatanModel kegiatan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(kegiatan.namaKegiatan),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              "${ApiService.baseUrl}/${kegiatan.gambar}",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, size: 100);
              },
            ),
            SizedBox(height: 10),
            Text("Deskripsi: ${kegiatan.keterangan}"),
            Text("Lokasi: ${kegiatan.lokasi}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Tutup"),
          ),
        ],
      ),
    );
  }
}