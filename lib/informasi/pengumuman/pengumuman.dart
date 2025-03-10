import 'package:flutter/material.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/footer.dart';
import 'package:sipedes/informasi/pengumuman/detail_pengumuman.dart';

import '../kegiatan/detail_kegiatan.dart';

class Pengumuman extends StatelessWidget {
  final List<Map<String, String>> pengumuman = [
    {
      'no': '1',
      'judul': 'Membersihkan lingkungan desa',
      'keterangan': 'Balai Desa',
      'tanggal': '27 Januari 2030 / 08:00 WIB'
    },
    {
      'no': '2',
      'judul': 'Membersihkan lingkungan desa',
      'keterangan': 'Balai Desa',
      'tanggal': '27 Januari 2030 / 08:00 WIB'
    },
    {
      'no': '3',
      'judul': 'Membersihkan lingkungan desa',
      'keterangan': 'Balai Desa',
      'tanggal': '27 Januari 2030 / 08:00 WIB'
    },
    {
      'no': '4',
      'judul': 'Membersihkan lingkungan desa',
      'keterangan': 'Balai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai DesaBalai Desa',
      'tanggal': '27 Januari 2030 / 08:00 WIB'
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
                "Pengumuman",
                style: AppFont.duapuluhbold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Menyajikan informasi terbaru tentang peristiwa dan Pengumuman terkini dari Desa Larangan Slampar.',
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
                  DataColumn(label: Text('Judul')),
                  DataColumn(label: Text('Keterangan')),
                  DataColumn(label: Text('Tanggal',)),
                ],
                rows: pengumuman
                    .map(
                      (item) => DataRow(
                        onSelectChanged: (selected) {
                          if (selected != null && selected) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPengumuman(pengumuman: item),
                              ),
                            );
                          }
                        },
                        cells: [
                          DataCell(Text(item['no']!)),
                          DataCell(Text(item['judul']!)),
                          DataCell(Text(
                            (item['keterangan']!.length > 50)
                                ? '${item['keterangan']!.substring(0, 20)}...'
                                : item['keterangan']!,
                          )),

                          DataCell(Text(item['tanggal']!)),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(height: 100),
            FooterScreen(),
          ],
        ),
      ),
    );
  }
}
