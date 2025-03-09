import 'package:flutter/cupertino.dart';

class StrukturDesaView extends StatelessWidget {
  const StrukturDesaView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Struktur pemerintahan desa akan dijelaskan di sini...',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}