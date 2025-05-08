class Penyakit {
  final String nama;
  final List<int> gejala;
  final String deskripsi;
  final String gambar;
  final String penyebab;
  final String pencegahan;
  final String pengobatan;
  final String link;

  Penyakit({
    required this.nama,
    required this.gejala,
    required this.deskripsi,
    required this.gambar,
    required this.penyebab,
    required this.pencegahan,
    required this.pengobatan,
    required this.link
  });

  int hitungKecocokan(List<int> inputGejala) {
    int cocok = 0;
    for (int g in inputGejala) {
      if (gejala.contains(g)) {
        cocok++;
      }
    }
    return cocok;
  }

  double hitungPersenKecocokan(List<int> inputGejala) {
    int cocok = hitungKecocokan(inputGejala);
    double dariPenyakit = cocok / gejala.length;
    double dariUser = cocok / inputGejala.length;
    return ((dariPenyakit + dariUser) / 2) * 100;
  }
}
