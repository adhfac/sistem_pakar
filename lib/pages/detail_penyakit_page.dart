import 'package:flutter/material.dart';
import 'package:sistem_pakar/models/penyakit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPenyakitPage extends StatelessWidget {
  final Penyakit penyakit;
  DetailPenyakitPage({required this.penyakit});

  // Color scheme matching the diagnosis page
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
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          // Custom app bar with image
          SliverAppBar(
            expandedHeight: 220.0,
            floating: false,
            pinned: true,
            stretch: true,
            backgroundColor: primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                penyakit.nama,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Medical image
                  Image.asset(penyakit.gambar, fit: BoxFit.cover),
                  // Gradient overlay for better text visibility
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: [0.6, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              if (penyakit.link.isNotEmpty)
                IconButton(
                  icon: Icon(Icons.public, color: Colors.white),
                  onPressed: () async {
                    final url = Uri.parse(penyakit.link);
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    }
                  },
                  tooltip: "Buka referensi online",
                ),
              IconButton(
                icon: Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  // Implement share functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Bagikan informasi penyakit'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                tooltip: "Bagikan",
              ),
            ],
          ),

          // Content sections
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Disease description section
                  _buildSection(
                    title: "Deskripsi",
                    content: penyakit.deskripsi,
                    icon: Icons.info_outline,
                  ),

                  // Causes section
                  _buildSection(
                    title: "Penyebab",
                    content: penyakit.penyebab,
                    icon: Icons.coronavirus_outlined,
                  ),

                  // Prevention section
                  _buildSection(
                    title: "Pencegahan",
                    content: penyakit.pencegahan,
                    icon: Icons.health_and_safety_outlined,
                  ),

                  // Treatment section
                  _buildSection(
                    title: "Pengobatan",
                    content: penyakit.pengobatan,
                    icon: Icons.medical_services_outlined,
                  ),

                  // Symptoms section with chips
                  _buildSymptomsSection(context),

                  SizedBox(height: 24),

                  // Source reference box
                  if (penyakit.link.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.library_books, color: primaryColor),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sumber Referensi",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: textPrimaryColor,
                                  ),
                                ),
                                SizedBox(height: 4),
                                InkWell(
                                  onTap: () async {
                                    final url = Uri.parse(penyakit.link);
                                    if (await canLaunchUrl(url)) {
                                      launchUrl(url);
                                    }
                                  },
                                  child: Text(
                                    penyakit.link,
                                    style: GoogleFonts.nunito(
                                      color: secondaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentColor,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back_ios_new, color: Colors.white,),
        tooltip: "Kembali ke hasil diagnosa",
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor, size: 20),
              SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(color: Colors.grey.shade300),
          SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.nunito(
              fontSize: 16,
              height: 1.5,
              color: textPrimaryColor,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomsSection(BuildContext context) {
    // Get symptoms from model
    List<String> symptoms = [
      "Nyeri saat bicara atau menelan",
      "Suara serak",
      // We would extract these from the penyakit.gejala IDs
      // This is just a placeholder implementation
    ];

    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.sick_outlined, color: primaryColor, size: 20),
              SizedBox(width: 8),
              Text(
                "Gejala",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(color: Colors.grey.shade300),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                symptoms.map((symptom) {
                  return Chip(
                    label: Text(
                      symptom,
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: secondaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
