import 'package:flutter/material.dart';
import 'package:sistem_pakar/models/penyakit.dart';
import 'package:sistem_pakar/pages/detail_diagnosa_page.dart';

class DiagnosaPage extends StatefulWidget {
  @override
  _DiagnosaPageState createState() => _DiagnosaPageState();
}

class _DiagnosaPageState extends State<DiagnosaPage> {
  List<int> selectedGejala = [];

  final Map<int, String> gejalaMap = {
    1: 'Demam',
    2: 'Sakit kepala',
    3: 'Nyeri saat bicara atau menelan',
    4: 'Batuk',
    5: 'Hidung tersumbat',
    6: 'Nyeri telinga',
    7: 'Nyeri tenggorokan',
    8: 'Hidung meler',
    9: 'Letih dan lesu',
    10: 'Mual dan muntah',
    11: 'Selaput lendir merah dan bengkak',
    12: 'Ada benjolan di leher',
    13: 'Nyeri leher',
    14: 'Pembengkakan kelenjar getah bening',
    15: 'Pendarahan hidung',
    16: 'Suara serak',
    17: 'Bola mata bergerak tanpa sadar',
    18: 'Dahi sakit',
    19: 'Leher bengkak',
    20: 'Tuli',
    21: 'Ada yang tumbuh di mulut',
    22: 'Air liur menetes',
    23: 'Berat badan turun',
    24: 'Bunyi nafas abnormal',
    25: 'Infeksi sinus',
    26: 'Nyeri antara mata',
    27: 'Nyeri pinggir hidung',
    28: 'Nyeri pipi di bawah mata',
    29: 'Nyeri wajah',
    30: 'Perubahan kulit',
    31: 'Perubahan suara',
    32: 'Radang gendang telinga',
    33: 'Sakit gigi',
    34: 'Serangan vertigo',
    35: 'Telinga berdenging',
    36: 'Telinga terasa penuh',
    37: 'Tenggorokan gatal',
    38: 'Tubuh tak seimbang',
  };

  final List<Penyakit> penyakitList = [
    Penyakit("Contract Ulcers", [3, 16]),
    Penyakit("Abaes Parafaringeal", [3, 19]),
    Penyakit("Abaes Peritonailer", [1, 2, 7, 14, 16, 22]),
    Penyakit("Barotitis Media", [2, 6]),
    Penyakit("Deviasi Septum", [1, 5, 6, 15, 25, 29]),
    Penyakit("Faringitis", [1, 3, 7, 13, 14]),
    Penyakit("Kanker Laring", [3, 4, 7, 13, 16, 23, 24]),
    Penyakit("Kanker Leher dan Kepala", [3, 12, 15, 21, 30, 31]),
    Penyakit("Kanker Leher Metastatik", [12]),
    Penyakit("Kanker Nasofaring", [5, 15]),
    Penyakit("Kanker Tonsil", [7, 12]),
    Penyakit("Laringitis", [1, 3, 14, 19, 37]),
    Penyakit("Neuronitis Vestibularis", [10, 17]),
    Penyakit("Osteosklerosis", [20, 35]),
    Penyakit("Otitis Media Akut", [1, 6, 10, 32]),
    Penyakit("Meniere", [6, 10, 34, 36]),
    Penyakit("Tonsilitis", [1, 2, 3, 4, 7, 10]),
    Penyakit("Tumor Syaraf Pendengaran", [2, 20, 38]),
    Penyakit("Vertigo Postular", [17]),
    Penyakit("Sinusitis Maksilaris", [1, 2, 4, 5, 8, 9, 11, 28, 33]),
    Penyakit("Sinusitis Frontalis", [1, 2, 4, 5, 8, 9, 11, 18]),
    Penyakit("Sinusitis Etmoidalis", [1, 2, 4, 5, 8, 9, 11, 18, 26, 27]),
    Penyakit("Sinusitis Sfenoidalis", [1, 2, 4, 5, 6, 8, 9, 11, 12]),
    Penyakit("Perut", [1, 2, 3, 4]),
  ];

  void diagnosa() {
    if (selectedGejala.isEmpty) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text("Peringatan"),
              content: Text(
                "Silakan pilih minimal satu gejala terlebih dahulu.",
              ),
            ),
      );
      return;
    }

    final hasilDiagnosa =
        penyakitList
            .map((p) {
              final skor = p.hitungKecocokan(selectedGejala);
              final persen = p.hitungPersenKecocokan(selectedGejala);
              return {'penyakit': p, 'skor': skor, 'persen': persen};
            })
            .where((item) => (item['skor'] as int) > 0)
            .toList();

    hasilDiagnosa.sort(
      (a, b) => (b['persen'] as double).compareTo(a['persen'] as double),
    );

    final top5 = hasilDiagnosa.take(5).toList();

    if (top5.isNotEmpty) {
      String hasilText = top5
          .map((item) {
            final p = item['penyakit'] as Penyakit;
            final persen = item['persen'] as double;
            return "- ${p.nama} (${persen.toStringAsFixed(1)}%)";
          })
          .join('\n');

      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text("Hasil Diagnosa"),
              content: Text(hasilText),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Kembali"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => DetailDiagnosaPage(
                              hasilDiagnosa: hasilDiagnosa,
                            ),
                      ),
                    );
                  },
                  child: Text("Lihat Detail"),
                ),
              ],
            ),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text("Hasil Diagnosa"),
              content: Text("Tidak ditemukan penyakit yang cocok."),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diagnosa Penyakit THT')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Pilih Gejala yang Dirasakan:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...gejalaMap.entries.map(
            (entry) => CheckboxListTile(
              title: Text(entry.value),
              value: selectedGejala.contains(entry.key),
              onChanged: (val) {
                setState(() {
                  val!
                      ? selectedGejala.add(entry.key)
                      : selectedGejala.remove(entry.key);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: ElevatedButton(
              onPressed: diagnosa,
              child: Text("Diagnosa Sekarang"),
            ),
          ),
        ],
      ),
    );
  }
}
