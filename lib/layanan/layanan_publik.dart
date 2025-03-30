import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/theme/theme.dart';
import '../data/api_service/api_service.dart';
import '../data/model/surat.dart';
import 'daftar_surat.dart';

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

  Color _getStatusColor(String status) {
    if (status == 'Menunggu Verifikasi') {
      return Colors.orange[100]!;
    } else if (status == 'Diproses') {
      return Colors.green[100]!;
    } else if (status == 'Siap Diambil') {
      return Colors.yellow[100]!;

    } else if (status == 'Ditolak') {
      return Colors.red[100]!;
    } else {
      return Colors.grey[200]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.appbar,
        title: Text('Daftar Pengajuan Surat',
            style: AppFont.duaempat.copyWith(color: AppColor.white)),
        centerTitle: true,
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
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppDimen.w16, vertical: AppDimen.h4),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        color: _getStatusColor(surat.status),
                        child: Padding(
                          padding: EdgeInsets.all(16.0.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                surat.jenisSurat,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0.sp,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8.0.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Penting untuk rata atas
                                children: [
                                  Text(
                                    "Status    :",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 8.0.h),
                                  Expanded(
                                    child: Text(
                                      "${surat.status}",
                                      style: TextStyle(
                                        fontSize: 16.0.sp,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign
                                          .left, // Rata kiri untuk isi status
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Penting untuk rata atas
                                children: [
                                  Text(
                                    "Tanggal :",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 8.0.h),
                                  Expanded(
                                    child: Text(
                                      surat.tanggalPengajuan,
                                      style: TextStyle(
                                        fontSize: 16.0.sp,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign
                                          .left, // Rata kiri untuk isi tanggal
                                    ),
                                  ),
                                ],
                              ),
                              if (surat.status == 'Ditolak' &&
                                  surat.alasanPenolakan != null &&
                                  surat.alasanPenolakan!.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(),
                                    SizedBox(height: 8.0),
                                    Text(
                                      "Alasan Penolakan:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      surat.alasanPenolakan!,
                                      style: TextStyle(
                                        fontSize: 16.0.sp,
                                        color: Colors.red[900],
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
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
            MaterialPageRoute(builder: (context) => DaftarSurat()),
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
