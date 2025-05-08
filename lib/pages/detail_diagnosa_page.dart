import 'package:flutter/material.dart';
import 'package:sistem_pakar/models/penyakit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistem_pakar/pages/detail_penyakit_page.dart';

class DetailDiagnosaPage extends StatelessWidget {
  final List<Map<String, Object>> hasilDiagnosa;

  DetailDiagnosaPage({required this.hasilDiagnosa});

  // Color scheme matching the other pages
  final Color primaryColor = Color(0xFF1A75BC); // Medical blue
  final Color secondaryColor = Color(0xFF3AAED8); // Lighter blue
  final Color accentColor = Color(0xFFE74C3C); // Accent red
  final Color backgroundColor = Color(0xFFF5F7FA); // Light background
  final Color textPrimaryColor = Color(0xFF2C3E50); // Dark blue text
  final Color textSecondaryColor = Color(0xFF7F8C8D); // Subtle gray

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,),
          onPressed: () {
            Navigator.pop(
              context,
            ); // Menutup halaman dan kembali ke halaman sebelumnya
          },
        ),
        title: Text(
          "Detail Hasil Diagnosa",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Info header
          Container(
            color: primaryColor,
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kemungkinan Penyakit',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Berdasarkan gejala yang Anda pilih',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          // Stats summary
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  'Total Penyakit',
                  '${hasilDiagnosa.length}',
                  Icons.medical_services_outlined,
                ),
                _buildStatItem(
                  'Kecocokan Tertinggi',
                  '${_getHighestPercentage().toStringAsFixed(1)}%',
                  Icons.analytics_outlined,
                ),
                _buildStatItem(
                  'Rata-rata Kecocokan',
                  '${_getAveragePercentage().toStringAsFixed(1)}%',
                  Icons.query_stats,
                ),
              ],
            ),
          ),

          // Divider with text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(child: Divider(color: Colors.grey.shade300)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'DAFTAR KEMUNGKINAN',
                    style: GoogleFonts.montserrat(
                      color: textSecondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey.shade300)),
              ],
            ),
          ),

          // List of diseases
          Expanded(
            child:
                hasilDiagnosa.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: hasilDiagnosa.length,
                      itemBuilder: (context, index) {
                        final item = hasilDiagnosa[index];
                        final penyakit = item['penyakit'] as Penyakit;
                        final persen = item['persen'] as double;
                        final skor = item['skor'] as int;

                        // Determine color based on percentage
                        final matchColor =
                            persen > 75
                                ? Colors.red.shade700
                                : persen > 50
                                ? Colors.orange
                                : persen > 25
                                ? Colors.amber.shade700
                                : Colors.green;

                        return Card(
                          elevation: 1,
                          margin: EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => DetailPenyakitPage(
                                        penyakit: penyakit,
                                      ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // Percentage indicator
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: matchColor.withOpacity(0.15),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${persen.toStringAsFixed(0)}%',
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: matchColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16),

                                      // Disease name and rank
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                if (index < 3)
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 2,
                                                        ),
                                                    margin: EdgeInsets.only(
                                                      right: 8,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          index == 0
                                                              ? Colors
                                                                  .amber
                                                                  .shade700
                                                              : index == 1
                                                              ? Colors
                                                                  .blueGrey
                                                                  .shade300
                                                              : Colors
                                                                  .brown
                                                                  .shade300,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            4,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      '#${index + 1}',
                                                      style:
                                                          GoogleFonts.montserrat(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                Expanded(
                                                  child: Text(
                                                    penyakit.nama,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                          color:
                                                              textPrimaryColor,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Skor kecocokan: $skor dari ${penyakit.gejala.length}',
                                              style: GoogleFonts.nunito(
                                                fontSize: 14,
                                                color: textSecondaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Arrow icon
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                        color: primaryColor,
                                      ),
                                    ],
                                  ),

                                  // Symptoms match visualization
                                  SizedBox(height: 16),
                                  Text(
                                    'Kecocokan Gejala:',
                                    style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: textSecondaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: persen / 100,
                                      backgroundColor: Colors.grey.shade200,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        matchColor,
                                      ),
                                      minHeight: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back_ios_new, color: Colors.white,),
        tooltip: "Kembali ke diagnosa",
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: primaryColor, size: 24),
        SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.nunito(fontSize: 12, color: textSecondaryColor),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 80, color: Colors.grey.shade400),
          SizedBox(height: 16),
          Text(
            'Tidak ada hasil diagnosa',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textPrimaryColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Silakan pilih gejala yang Anda alami',
            style: GoogleFonts.nunito(fontSize: 14, color: textSecondaryColor),
          ),
        ],
      ),
    );
  }

  double _getHighestPercentage() {
    if (hasilDiagnosa.isEmpty) return 0.0;
    double highest = 0.0;
    for (var item in hasilDiagnosa) {
      double persen = item['persen'] as double;
      if (persen > highest) highest = persen;
    }
    return highest;
  }

  double _getAveragePercentage() {
    if (hasilDiagnosa.isEmpty) return 0.0;
    double total = 0.0;
    for (var item in hasilDiagnosa) {
      total += item['persen'] as double;
    }
    return total / hasilDiagnosa.length;
  }
}
