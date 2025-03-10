import 'package:flutter/material.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/footer.dart';
import 'package:sipedes/informasi/kegiatan/detail_kegiatan.dart';

class Kegiatan extends StatelessWidget {
  final List<Map<String, String>> dataKegiatan = [
    {
      'no': '1',
      'gambar': ImgString.kegiatan1,
      'kegiatan': 'Gotong Royong',
      'keterangan': 'Membersihkan lingkungan desa',
      'mulai': '27 Januari 2030 / 08:00 WIB',
      'selesai': '29 Januari 2030 / 14:00 WIB',
      'lokasi': 'Balai Desa'
    },
    {
      'no': '2',
      'gambar': ImgString.kegiatan2,
      'kegiatan': 'Pelatihan UMKM',
      'keterangan': 'Pelatihan pembuatan kerajinan',
      'mulai': '27 Januari 2030 / 08:00 WIB',
      'selesai': '29 Januari 2030 / 14:00 WIB',
      'lokasi': 'Gedung Serbaguna'
    },
    {
      'no': '3',
      'gambar': ImgString.kegiatan3,
      'kegiatan': 'Gotong Royong',
      'keterangan': 'Membersihkan lingkungan desa',
      'mulai': '27 Januari 2030 / 08:00 WIB',
      'selesai': '29 Januari 2030 / 14:00 WIB',
      'lokasi': 'Balai Desa'
    },
    {
      'no': '4',
      'gambar': ImgString.kegiatan4,
      'kegiatan': 'Pelatihan UMKM',
      'keterangan': 'Pelatihan pembuatan kerajinan',
      'mulai': '27 Januari 2030 / 08:00 WIB',
      'selesai': '29 Januari 2030 / 14:00 WIB',
      'lokasi': 'Gedung Serbaguna'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Kegiatan",
                style: AppFont.duapuluhbold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Menyajikan informasi terbaru tentang peristiwa dan kegiatan terkini dari Desa Larangan Slampar.',
                style: AppFont.duabelas,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
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
                rows: dataKegiatan
                    .map(
                      (item) => DataRow(
                    onSelectChanged: (selected) {
                      if (selected != null && selected) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailKegiatanScreen(data: item),
                          ),
                        );
                      }
                    },
                    cells: [
                      DataCell(Text(item['no']!)),
                      DataCell(
                        item['gambar']!.startsWith('http')
                            ? Image.network(item['gambar']!,
                            width: 50, height: 50, fit: BoxFit.cover)
                            : Image.asset(item['gambar']!,
                            width: 50, height: 50, fit: BoxFit.cover),
                      ),
                      DataCell(Text(item['kegiatan']!)),
                      DataCell(Text(item['keterangan']!)),
                      DataCell(Text(item['mulai']!)),
                      DataCell(Text(item['selesai']!)),
                      DataCell(Text(item['lokasi']!)),
                    ],
                  ),
                )
                    .toList(),
              ),
            ),
            SizedBox(height:100),
            FooterScreen(),
          ],
        ),
      ),
    );
  }
}

