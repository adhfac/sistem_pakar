import 'package:flutter/material.dart';
import 'package:sistem_pakar/models/penyakit.dart';

class DetailDiagnosaPage extends StatelessWidget {
  final List<Map<String, Object>> hasilDiagnosa;

  DetailDiagnosaPage({required this.hasilDiagnosa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Diagnosa")),
      body: ListView.builder(
        itemCount: hasilDiagnosa.length,
        itemBuilder: (context, index) {
          final item = hasilDiagnosa[index];
          final penyakit = item['penyakit'] as Penyakit;
          final persen = item['persen'] as double;

          return ListTile(
            title: Text(penyakit.nama),
            trailing: Text("${persen.toStringAsFixed(1)}%"),
          );
        },
      ),
    );
  }
}
