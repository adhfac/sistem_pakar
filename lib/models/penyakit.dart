class Penyakit {
  final String nama;
  final List<int> gejala;

  Penyakit(this.nama, this.gejala);

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
