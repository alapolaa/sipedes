import 'package:flutter/material.dart';
import 'data/api_service/api_service.dart';
import 'data/model/struktur.dart';

class StrukturDesaPage extends StatefulWidget {
  @override
  _StrukturDesaPageState createState() => _StrukturDesaPageState();
}

class _StrukturDesaPageState extends State<StrukturDesaPage> {
  late Future<List<StrukturDesaModel>> futureStrukturDesa;

  @override
  void initState() {
    super.initState();
    futureStrukturDesa = ApiService().fetchStrukturDesa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Struktur Desa')),
      body: FutureBuilder<List<StrukturDesaModel>>(
        future: futureStrukturDesa,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Data tidak tersedia'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final struktur = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(
                      "${ApiService.baseUrl}/${struktur.gambar}",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.person, size: 50),
                    ),
                    title: Text(struktur.nama, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(struktur.jabatan),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
