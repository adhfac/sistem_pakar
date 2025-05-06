import 'package:flutter/material.dart';
import 'package:sistem_pakar/models/penyakit.dart';
import 'package:google_fonts/google_fonts.dart';

// Define custom theme class
class AppTheme {
  // Primary color palette - Medical blue/teal theme
  static const Color primaryColor = Color(0xFF0A8EA0);
  static const Color primaryLightColor = Color(0xFFE0F7FA);
  static const Color accentColor = Color(0xFF00BCD4);
  static const Color secondaryColor = Color(0xFF546E7A);

  // Neutrals
  static const Color backgroundLight = Color(0xFFF5F9FA);
  static const Color cardColor = Colors.white;
  static const Color dividerColor = Color(0xFFE0E0E0);

  // Text colors
  static const Color textDark = Color(0xFF263238);
  static const Color textMedium = Color(0xFF546E7A);
  static const Color textLight = Color(0xFF90A4AE);

  // Status colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFFA000);
  static const Color errorColor = Color(0xFFE53935);

  // Generate ThemeData
  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        background: backgroundLight,
        surface: cardColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: textDark,
        onSurface: textDark,
        error: errorColor,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        displayMedium: GoogleFonts.montserrat(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        displaySmall: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: GoogleFonts.nunito(fontSize: 16, color: textDark),
        bodyMedium: GoogleFonts.nunito(fontSize: 14, color: textMedium),
        bodySmall: GoogleFonts.nunito(fontSize: 12, color: textLight),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          textStyle: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        hintStyle: GoogleFonts.nunito(color: textLight, fontSize: 14),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: cardColor,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      dividerTheme: DividerThemeData(color: dividerColor, thickness: 1),
    );
  }
}

class DiagnosaPage extends StatefulWidget {
  @override
  _DiagnosaPageState createState() => _DiagnosaPageState();
}

class _DiagnosaPageState extends State<DiagnosaPage> {
  List<int> selectedGejala = [];
  String searchQuery = '';

  // Symptom categories
  final Map<String, List<int>> categories = {
    'Kepala': [2, 18, 29],
    'Hidung': [5, 8, 15, 25, 26, 27],
    'Telinga': [6, 20, 32, 34, 35, 36, 38],
    'Tenggorokan': [3, 7, 16, 22, 24, 31, 37],
    'Leher': [12, 13, 14, 19],
    'Umum': [1, 4, 9, 10, 11, 17, 21, 23, 28, 30, 33],
  };

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

  // Get filtered symptoms based on search query
  List<MapEntry<int, String>> getFilteredSymptoms() {
    if (searchQuery.isEmpty) {
      return gejalaMap.entries.toList();
    }
    return gejalaMap.entries
        .where(
          (entry) =>
              entry.value.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
  }

  // Get symptoms by category
  List<MapEntry<int, String>> getSymptomsByCategory(String category) {
    final categoryIds = categories[category] ?? [];
    return gejalaMap.entries
        .where((entry) => categoryIds.contains(entry.key))
        .where(
          (entry) =>
              searchQuery.isEmpty ||
              entry.value.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
  }

  void diagnosa() {
    if (selectedGejala.isEmpty) {
      _showErrorDialog("Silakan pilih minimal satu gejala terlebih dahulu.");
      return;
    }

    Map<Penyakit, double> hasilDiagnosa = {};

    for (var p in penyakitList) {
      double persen = p.hitungPersenKecocokan(selectedGejala);
      if (persen > 0) {
        hasilDiagnosa[p] = persen;
      }
    }

    if (hasilDiagnosa.isNotEmpty) {
      var sortedResults =
          hasilDiagnosa.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));

      _showResultDialog(sortedResults);
    } else {
      _showErrorDialog(
        "Tidak ditemukan penyakit yang cocok dengan gejala yang dipilih.",
      );
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              "Peringatan",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                color: AppTheme.errorColor,
              ),
            ),
            content: Text(message, style: GoogleFonts.nunito()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "OK",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  void _showResultDialog(List<MapEntry<Penyakit, double>> results) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              "Hasil Diagnosa",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
            content: Container(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Berdasarkan gejala yang dipilih, berikut adalah kemungkinan penyakit:",
                      style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    ...results.take(3).map((entry) {
                      // Assign colors based on percentage
                      Color progressColor = AppTheme.primaryColor;
                      if (entry.value < 40) {
                        progressColor = AppTheme.warningColor;
                      } else if (entry.value > 75) {
                        progressColor = AppTheme.successColor;
                      }

                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.key.nama,
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: LinearProgressIndicator(
                                        value: entry.value / 100,
                                        minHeight: 12,
                                        backgroundColor: AppTheme.dividerColor,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              progressColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    "${entry.value.toStringAsFixed(1)}%",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      color: progressColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLightColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppTheme.primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Hasil diagnosa ini hanya berdasarkan gejala yang Anda pilih. Konsultasikan dengan dokter untuk diagnosa yang akurat.",
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                color: AppTheme.textMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "TUTUP",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.theme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Diagnosa Penyakit THT',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sistem Pakar Diagnosa THT",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Pilih gejala yang Anda alami untuk mendapatkan diagnosa penyakit THT",
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      style: GoogleFonts.nunito(),
                      decoration: InputDecoration(
                        hintText: "Cari gejala...",
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppTheme.primaryColor,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (selectedGejala.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.successColor.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.successColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: AppTheme.successColor,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Gejala terpilih: ${selectedGejala.length}",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.successColor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedGejala.clear();
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppTheme.successColor.withOpacity(0.1),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Reset",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.successColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ).paddingSymmetric(horizontal: 16),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child:
                    searchQuery.isNotEmpty
                        ? _buildSearchResults()
                        : _buildCategoryView(),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, -2),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: diagnosa,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.medical_services_outlined),
                      SizedBox(width: 8),
                      Text(
                        "DIAGNOSA SEKARANG",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    final filteredSymptoms = getFilteredSymptoms();

    if (filteredSymptoms.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: AppTheme.textLight),
            SizedBox(height: 16),
            Text(
              "Tidak ditemukan gejala yang sesuai",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.textMedium,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Coba kata kunci lain",
              style: GoogleFonts.nunito(color: AppTheme.textLight),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredSymptoms.length,
      itemBuilder: (context, index) {
        final entry = filteredSymptoms[index];
        return _buildSymptomTile(entry);
      },
    );
  }

  Widget _buildCategoryView() {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories.keys.elementAt(index);
        final categorySymptoms = getSymptomsByCategory(category);

        if (categorySymptoms.isEmpty) {
          return SizedBox.shrink();
        }

        return Card(
          margin: EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExpansionTile(
            title: Text(
              category,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
              ),
            ),
            leading: _getCategoryIcon(category),
            initiallyExpanded: true,
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            children: categorySymptoms.map(_buildSymptomTile).toList(),
          ),
        );
      },
    );
  }

  Widget _getCategoryIcon(String category) {
    IconData iconData;
    Color iconColor = AppTheme.primaryColor;

    switch (category) {
      case 'Kepala':
        iconData = Icons.face;
        break;
      case 'Hidung':
        iconData = Icons.tag_faces;
        break;
      case 'Telinga':
        iconData = Icons.hearing;
        break;
      case 'Tenggorokan':
        iconData = Icons.record_voice_over;
        break;
      case 'Leher':
        iconData = Icons.personal_injury;
        break;
      case 'Umum':
      default:
        iconData = Icons.medical_services;
        break;
    }

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.primaryLightColor,
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: iconColor, size: 20),
    );
  }

  Widget _buildSymptomTile(MapEntry<int, String> entry) {
    final isSelected = selectedGejala.contains(entry.key);

    return ListTile(
      title: Text(
        entry.value,
        style: GoogleFonts.nunito(
          color: isSelected ? AppTheme.primaryColor : AppTheme.textDark,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : AppTheme.dividerColor,
            width: 2,
          ),
        ),
        child:
            isSelected
                ? Icon(Icons.check, size: 16, color: Colors.white)
                : null,
      ),
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedGejala.remove(entry.key);
          } else {
            selectedGejala.add(entry.key);
          }
        });
      },
    );
  }
}

// Extension to add padding to widgets
extension PaddingExtension on Widget {
  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }
}
