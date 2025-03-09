import 'package:flutter/cupertino.dart';

class VisiMisiView extends StatelessWidget {
  const VisiMisiView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Visi dan Misi desa akan dijelaskan di sini...',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}