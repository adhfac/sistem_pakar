import 'package:flutter/material.dart';
import 'package:sistem_pakar/models/penyakit.dart';
import 'package:sistem_pakar/pages/detail_diagnosa_page.dart';
import 'package:sistem_pakar/pages/detail_penyakit_page.dart';
import 'package:google_fonts/google_fonts.dart';

class DiagnosaPage extends StatefulWidget {
  @override
  _DiagnosaPageState createState() => _DiagnosaPageState();
}

class _DiagnosaPageState extends State<DiagnosaPage> {
  List<int> selectedGejala = [];
  final ScrollController _scrollController = ScrollController();

  // Custom color scheme for medical app
  final Color primaryColor = Color(0xFF1A75BC); // Medical blue
  final Color secondaryColor = Color(0xFF3AAED8); // Lighter blue
  final Color accentColor = Color(
    0xFFE74C3C,
  ); // Accent red for warnings/important elements
  final Color backgroundColor = Color(0xFFF5F7FA); // Light background
  final Color cardColor = Colors.white;
  final Color textPrimaryColor = Color(0xFF2C3E50); // Dark blue text
  final Color textSecondaryColor = Color(
    0xFF7F8C8D,
  ); // Subtle gray for secondary text

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

  // Organize symptoms by category for better UX
  final Map<String, List<int>> gejalaByCategory = {
    'Gejala Umum': [1, 2, 9, 23],
    'Kepala dan Wajah': [18, 26, 28, 29],
    'Hidung': [5, 8, 15, 25, 27],
    'Telinga': [6, 20, 32, 34, 35, 36, 38],
    'Tenggorokan': [3, 7, 16, 21, 22, 24, 31, 37],
    'Leher': [12, 13, 14, 19],
    'Lainnya': [4, 10, 11, 17, 30, 33],
  };

  // The rest of the penyakitList is unchanged
  final List<Penyakit> penyakitList = [
    Penyakit(
      nama: "Contract Ulcers",
      gejala: [3, 16],
      deskripsi:
          "Ulkus kontak adalah luka terbuka atau erosi pada selaput lendir yang menutupi tulang rawan tempat melekatnya pita suara (kartilago aritenoid). Luka ini biasanya terjadi di bagian belakang pita suara.",
      gambar: 'images/ContractUlcers.png',
      penyebab:
          'Penyebab utama ulkus kontak adalah penggunaan suara yang terlalu kuat, terutama saat memulai berbicara. Ini sering terjadi pada orang yang pekerjaannya menuntut banyak bicara atau menggunakan suara keras, seperti penyanyi, guru, pengkhotbah, atau sales. Trauma akibat intubasi endotrakeal (pemasangan selang pernapasan) juga dapat menyebabkan ulkus kontak jika ukuran selang tidak sesuai. Selain itu, refluks asam lambung (GERD) dapat memperparah atau menyebabkan ulkus ini.',
      pencegahan:
          'Untuk mencegah ulkus kontak dan nodul pita suara, penting untuk menerapkan teknik penggunaan suara yang baik seperti menghindari penggunaan suara berlebihan, berteriak, atau berbisik berlebihan, serta menggunakan pernapasan diafragma dan artikulasi yang jelas. Menjaga kesehatan pita suara melalui hidrasi yang cukup, menghindari iritan seperti asap rokok dan polusi, mengelola refluks asam lambung, istirahat yang cukup, dan menghindari menggaruk tenggorokan berlebihan juga krusial. Selain itu, perhatikan kondisi kesehatan dengan mengistirahatkan suara saat sakit dan menghindari obat-obatan yang mengeringkan, serta menggunakan alat bantu seperti mikrofon jika diperlukan.',
      pengobatan:
          'Pengobatan ulkus kontak dan nodul pita suara umumnya melibatkan terapi suara untuk memperbaiki teknik penggunaan suara dan mengurangi tekanan pada pita suara, seringkali dikombinasikan dengan istirahat suara pada awalnya. Penanganan kondisi penyerta seperti refluks asam lambung atau infeksi juga penting, dan obat anti-inflamasi dapat digunakan untuk mengurangi peradangan pada ulkus kontak. Pembedahan jarang diperlukan, terutama untuk nodul yang tidak merespon terapi suara, namun selalu diikuti dengan terapi suara untuk mencegah kekambuhan. Kunci keberhasilan pengobatan adalah diagnosis yang tepat oleh dokter spesialis THT dan kepatuhan pasien terhadap rencana terapi yang komprehensif.',
      link: 'https://www.terapisehat.com/2010/10/contact-ulcers.html',
    ),
    Penyakit(
      nama: "Abses Parafaringeal",
      gejala: [3, 19],
      deskripsi:
          "Kumpulan nanah yang terbentuk di ruang parafaringeal, sering kali akibat infeksi bakteri.",
      gambar: 'images/AbsesParafaringeal.png',
      penyebab:
          'Penyebab utama abses parafaringeal adalah penyebaran infeksi bakteri dari area sekitarnya, seperti tonsilitis (radang amandel), faringitis (radang tenggorokan), infeksi gigi (terutama gigi molar bawah), mastoiditis (infeksi telinga bagian belakang), atau infeksi kelenjar ludah. Trauma pada area leher atau komplikasi setelah operasi di daerah tersebut juga dapat menjadi penyebab yang lebih jarang.',
      pencegahan:
          'Pencegahan abses parafaringeal berfokus pada penanganan dini dan efektif dari infeksi di area kepala dan leher. Langkah-langkah pencegahan meliputi: segera berkonsultasi dengan dokter jika mengalami sakit tenggorokan parah atau infeksi telinga, gigi, atau kelenjar ludah; mengikuti anjuran dokter dalam pengobatan infeksi hingga tuntas; menjaga kebersihan mulut dan gigi untuk mencegah infeksi gigi; dan menghindari trauma pada area leher.',
      pengobatan:
          'Pengobatan abses parafaringeal umumnya memerlukan tindakan agresif karena potensi komplikasi yang serius. Pilihan pengobatan utama meliputi: drainase bedah abses untuk mengeluarkan nanah, yang biasanya dilakukan melalui sayatan di leher atau dalam mulut; pemberian antibiotik intravena spektrum luas untuk mengatasi infeksi bakteri; perawatan suportif seperti hidrasi cairan, manajemen nyeri, dan pemantauan ketat kondisi pasien di rumah sakit. Dalam beberapa kasus, mungkin diperlukan tindakan bedah lebih lanjut untuk mengatasi sumber infeksi atau komplikasi yang timbul.',
      link: 'https://medicastore.com/penyakit/823/abses-parafaringeal',
    ),
    Penyakit(
      nama: "Abses Peritonsiler",
      gejala: [1, 2, 7, 14, 16, 22],
      deskripsi:
          "Kumpulan nanah yang terletak di belakang amandel (tonsil). Kondisi ini biasanya merupakan komplikasi dari tonsilitis (radang amandel) yang tidak diobati atau tidak responsif terhadap pengobatan.",
      gambar: 'images/AbsesPeritonailer.png',
      penyebab:
          'Penyebab utama abses peritonsiler adalah infeksi bakteri, biasanya *Streptococcus pyogenes* (bakteri penyebab radang tenggorokan), yang menyebar dari amandel yang terinfeksi ke ruang di sekitarnya. Proses ini menyebabkan peradangan dan pembentukan nanah di ruang peritonsiler.',
      pencegahan:
          'Pencegahan abses peritonsiler terutama berfokus pada penanganan dini dan efektif dari tonsilitis. Langkah-langkah pencegahan meliputi: segera berkonsultasi dengan dokter jika mengalami gejala radang tenggorokan; mengikuti anjuran dokter dan mengonsumsi antibiotik sesuai resep hingga tuntas untuk memberantas infeksi bakteri; dan mempertimbangkan tonsilektomi (pengangkatan amandel) pada kasus tonsilitis berulang yang sering terjadi.',
      pengobatan:
          'Pengobatan abses peritonsiler umumnya memerlukan tindakan medis segera. Pilihan pengobatan utama meliputi: drainase abses untuk mengeluarkan nanah, yang dapat dilakukan dengan aspirasi jarum, insisi dan drainase; pemberian antibiotik (biasanya intravena pada awalnya, diikuti oral) untuk mengatasi infeksi bakteri; manajemen nyeri dengan obat pereda nyeri; dan tonsilektomi (pengangkatan amandel) mungkin dipertimbangkan, terutama jika pasien memiliki riwayat abses peritonsiler berulang atau tonsilitis kronis.',
      link:
          'https://www.alodokter.com/abses-peritonsil-penyebab-dan-cara-penanganannya',
    ),
    Penyakit(
      nama: "Barotitis Media",
      gejala: [2, 6],
      deskripsi:
          "Kondisi telinga tengah yang disebabkan oleh perbedaan tekanan udara antara telinga tengah dan lingkungan sekitar. Perbedaan tekanan ini sering terjadi saat perubahan ketinggian yang cepat, seperti saat terbang dengan pesawat, menyelam, atau mendaki gunung.",
      gambar: 'images/BarotitisMedia.png',
      penyebab:
          'Penyebab utama barotitis media adalah ketidakmampuan tuba eustachius (saluran yang menghubungkan telinga tengah dengan bagian belakang tenggorokan) untuk menyeimbangkan tekanan udara. Perubahan tekanan udara yang cepat di lingkungan sekitar menyebabkan tekanan di telinga tengah menjadi relatif lebih tinggi atau lebih rendah, yang dapat menarik atau mendorong gendang telinga ke dalam atau ke luar, menyebabkan rasa sakit dan gejala lainnya. Kondisi seperti pilek, alergi, atau infeksi sinus dapat memperburuk barotitis media karena dapat menyebabkan penyempitan atau penyumbatan tuba eustachius.',
      pencegahan:
          'Pencegahan barotitis media berfokus pada upaya untuk membantu menyeimbangkan tekanan udara di telinga tengah selama perubahan ketinggian. Beberapa langkah pencegahan meliputi: melakukan manuver Valsava (menutup hidung dan mulut lalu mencoba menghembuskan napas dengan lembut) saat pesawat lepas landas dan mendarat atau saat menyelam; mengunyah permen karet atau mengisap permen selama perubahan ketinggian; menguap lebar; menggunakan semprotan hidung dekongestan sebelum terbang atau menyelam (dengan konsultasi dokter); menghindari tidur saat pesawat lepas landas atau mendarat agar tetap sadar dan dapat melakukan manuver penyeimbangan tekanan; dan menunda penerbangan atau penyelaman jika sedang mengalami pilek, alergi, atau infeksi sinus.',
      pengobatan:
          'Pengobatan barotitis media biasanya bertujuan untuk membantu membuka tuba eustachius dan menyeimbangkan tekanan di telinga tengah. Langkah-langkah pengobatan meliputi: melakukan manuver Valsava atau manuver Toynbee (menutup hidung sambil menelan); menggunakan dekongestan oral atau semprotan hidung (dengan konsultasi dokter); obat pereda nyeri seperti ibuprofen atau parasetamol untuk mengurangi rasa sakit; kompres hangat pada telinga; dan dalam kasus yang parah atau berkepanjangan, dokter THT mungkin melakukan miringotomi (sayatan kecil pada gendang telinga) untuk membantu mengeluarkan cairan atau menyeimbangkan tekanan. Sebagian besar kasus barotitis media akan sembuh dengan sendirinya atau dengan pengobatan konservatif.',
      link: 'https://medicastore.com/penyakit/802/barotitis-media-barotrauma',
    ),
    Penyakit(
      nama: "Deviasi Septum",
      gejala: [1, 5, 6, 15, 25, 29],
      deskripsi:
          "Kondisi umum di mana septum nasal (dinding tulang dan tulang rawan yang memisahkan kedua rongga hidung) tidak lurus, melainkan miring ke satu sisi. Banyak orang memiliki deviasi septum ringan tanpa menyadarinya, namun deviasi yang signifikan dapat menyebabkan berbagai masalah pernapasan dan hidung.",
      gambar: 'images/DeviasiSeptum.png',
      penyebab:
          'Deviasi septum dapat terjadi akibat beberapa faktor. Beberapa orang dilahirkan dengan septum yang bengkok (kongenital). Cedera pada hidung, seperti akibat jatuh atau terbentur saat olahraga, juga dapat menyebabkan atau memperparah deviasi septum. Proses penuaan juga dapat menyebabkan perubahan pada struktur hidung dan memperburuk deviasi septum seiring waktu.',
      pencegahan:
          'Sebagian besar kasus deviasi septum tidak dapat dicegah karena seringkali merupakan kondisi bawaan atau akibat cedera yang tidak terduga. Namun, beberapa tindakan dapat membantu mengurangi risiko cedera pada hidung, seperti menggunakan alat pelindung wajah saat berolahraga yang berisiko tinggi mengalami benturan di wajah, dan berhati-hati untuk menghindari cedera saat beraktivitas sehari-hari.',
      pengobatan:
          'Pengobatan deviasi septum tergantung pada tingkat keparahan gejala. Banyak orang dengan deviasi septum ringan tidak memerlukan pengobatan. Jika gejala mengganggu, pilihan pengobatan meliputi: obat-obatan seperti dekongestan, antihistamin, atau semprotan hidung steroid untuk membantu meredakan gejala hidung tersumbat, pilek, atau alergi (namun obat-obatan ini tidak memperbaiki deviasi septum itu sendiri); dan septoplasti, yaitu prosedur bedah untuk memperbaiki dan meluruskan septum nasal. Septoplasti biasanya direkomendasikan jika gejala signifikan dan tidak membaik dengan obat-obatan. Tujuan dari septoplasti adalah untuk memperbaiki aliran udara melalui hidung.',
      link:
          'https://rsupsoeradji.id/deviasi-septum/#:~:text=Deviasi%20septum%20adalah%20kondisi%20ketika,sering%20tersumbat%20dan%20sinusitis%20berulang.',
    ),
    Penyakit(
      nama: "Faringitis",
      gejala: [1, 3, 7, 13, 14],
      deskripsi:
          "Peradangan pada faring, yaitu bagian belakang tenggorokan yang terletak di antara amandel dan laring (kotak suara). Faringitis sering disebut sebagai sakit tenggorokan.",
      gambar: 'images/Faringitis.png',
      penyebab:
          'Penyebab faringitis sangat bervariasi. Penyebab yang paling umum adalah infeksi virus, seperti virus penyebab flu, pilek, campak, cacar air, atau mononukleosis. Faringitis juga dapat disebabkan oleh infeksi bakteri, yang paling umum adalah bakteri *Streptococcus pyogenes* (penyebab radang tenggorokan atau *strep throat*). Penyebab lain yang kurang umum meliputi infeksi jamur, alergi, iritasi akibat polusi udara, asap rokok, atau bahan kimia, serta penyakit asam lambung (GERD).',
      pencegahan:
          'Pencegahan faringitis sangat bergantung pada penyebabnya. Untuk faringitis yang disebabkan oleh infeksi, langkah-langkah pencegahan meliputi: sering mencuci tangan dengan sabun dan air, terutama setelah batuk atau bersin dan sebelum makan; menghindari menyentuh wajah (terutama mata, hidung, dan mulut) dengan tangan yang tidak bersih; menghindari kontak dekat dengan orang yang sakit; tidak berbagi makanan, minuman, atau peralatan makan dengan orang lain; dan menjaga daya tahan tubuh dengan istirahat yang cukup, makan makanan bergizi, dan berolahraga secara teratur. Menghindari paparan iritan seperti asap rokok dan polusi juga dapat membantu mencegah faringitis non-infeksius.',
      pengobatan:
          'Pengobatan faringitis bertujuan untuk meredakan gejala dan mengatasi penyebabnya. Untuk faringitis virus, pengobatan biasanya bersifat suportif dan meliputi istirahat yang cukup, minum banyak cairan hangat (seperti air, teh hangat dengan madu dan lemon, atau kaldu), berkumur dengan air garam hangat untuk meredakan sakit tenggorokan, dan mengonsumsi obat pereda nyeri seperti parasetamol atau ibuprofen untuk mengurangi demam dan nyeri. Faringitis bakteri (radang tenggorokan) memerlukan pengobatan dengan antibiotik yang diresepkan oleh dokter untuk memberantas bakteri dan mencegah komplikasi seperti demam rematik. Penting untuk menghabiskan seluruh dosis antibiotik sesuai anjuran dokter. Untuk faringitis akibat penyebab lain seperti alergi atau iritasi, menghindari pemicunya adalah kunci pengobatan.',
      link: 'https://www.alodokter.com/faringitis',
    ),
    Penyakit(
      nama: "Kanker Laring",
      gejala: [3, 4, 7, 13, 16, 23, 24],
      deskripsi:
          "Kanker yang berkembang di laring atau kotak suara. Laring terletak di leher, di atas trakea (pipa udara) dan merupakan bagian penting dalam produksi suara, pernapasan, dan menelan. Kanker laring dapat melibatkan berbagai bagian laring, termasuk pita suara, supraglotis (area di atas pita suara), dan subglotis (area di bawah pita suara).",
      gambar: 'images/KankerLaring.png',
      penyebab:
          'Penyebab pasti kanker laring belum sepenuhnya dipahami, namun beberapa faktor risiko utama telah diidentifikasi. Faktor risiko yang paling signifikan adalah merokok (termasuk rokok elektrik) dan konsumsi alkohol berlebihan. Kombinasi merokok dan minum alkohol secara signifikan meningkatkan risiko kanker laring. Faktor risiko lain meliputi infeksi human papillomavirus (HPV), terutama tipe 16; paparan zat kimia tertentu di tempat kerja (seperti debu asbes); riwayat keluarga dengan kanker kepala dan leher; usia di atas 60 tahun; dan jenis kelamin laki-laki lebih berisiko terkena kanker laring dibandingkan perempuan.',
      pencegahan:
          'Langkah-langkah pencegahan utama untuk kanker laring berfokus pada menghindari faktor risiko yang diketahui. Ini termasuk: berhenti merokok dan menghindari paparan asap rokok; mengurangi atau menghindari konsumsi alkohol; mendapatkan vaksinasi HPV (terutama untuk remaja dan dewasa muda); menghindari paparan zat kimia berbahaya di tempat kerja dengan menggunakan alat pelindung diri yang sesuai; menjaga kebersihan mulut dan gigi yang baik; dan menjalani pemeriksaan rutin jika memiliki faktor risiko tinggi.',
      pengobatan:
          'Pengobatan kanker laring sangat bergantung pada stadium kanker, lokasi tumor, ukuran tumor, dan kesehatan umum pasien. Pilihan pengobatan utama meliputi:* **Pembedahan:** Pengangkatan tumor dan jaringan di sekitarnya. Jenis pembedahan dapat bervariasi dari pengangkatan sebagian laring (laringektomi parsial) hingga pengangkatan seluruh laring (laringektomi total). Jika laring diangkat seluruhnya, pasien akan memerlukan trakeostomi permanen untuk bernapas.* **Terapi Radiasi (Radioterapi):** Penggunaan sinar berenergi tinggi untuk membunuh sel kanker. Radiasi dapat digunakan sebagai pengobatan utama untuk kanker stadium awal atau dikombinasikan dengan pembedahan atau kemoterapi.* **Kemoterapi:** Penggunaan obat-obatan untuk membunuh sel kanker di seluruh tubuh. Kemoterapi dapat digunakan sebelum pembedahan untuk mengecilkan tumor, setelah pembedahan untuk membunuh sel kanker yang tersisa, atau sebagai pengobatan utama untuk kanker stadium lanjut. * **Terapi Target:** Penggunaan obat-obatan yang menargetkan protein atau jalur spesifik yang terlibat dalam pertumbuhan sel kanker. * **Imunoterapi:** Terapi yang membantu sistem kekebalan tubuh pasien untuk melawan sel kanker. Seringkali, kombinasi dari beberapa modalitas pengobatan ini digunakan untuk mencapai hasil yang terbaik. Setelah pengobatan, rehabilitasi, termasuk terapi bicara dan menelan, sangat penting untuk membantu pasien beradaptasi dengan perubahan akibat pengobatan.',
      link: 'https://www.alodokter.com/kanker-laring',
    ),
    Penyakit(
      nama: "Kanker Leher dan Kepala",
      gejala: [3, 12, 15, 21, 30, 31],
      deskripsi:
          "Kanker yang menyerang berbagai area di kepala dan leher, termasuk mulut, tenggorokan (faring dan laring), hidung dan sinus paranasal, kelenjar ludah, dan kelenjar getah bening di leher. Kanker ini dapat berkembang di sel skuamosa (lapisan permukaan lembap di area tersebut), tetapi juga dapat berasal dari jenis sel lain.",
      gambar: 'images/KankerLeherKepala.png',
      penyebab:
          'Faktor risiko utama untuk kanker kepala dan leher sangat mirip dengan kanker laring, yaitu penggunaan tembakau (dalam bentuk apapun, termasuk rokok, cerutu, tembakau kunyah, dan rokok elektrik) dan konsumsi alkohol berlebihan. Kombinasi keduanya memiliki efek sinergis yang sangat meningkatkan risiko. Faktor risiko lain meliputi infeksi human papillomavirus (HPV), terutama tipe 16 (terkait dengan beberapa jenis kanker orofaringeal); paparan radiasi di kepala dan leher; paparan zat kimia tertentu di tempat kerja (seperti debu kayu, serat asbes, dan formaldehida); kebersihan mulut yang buruk; dan riwayat keluarga dengan kanker kepala dan leher. Beberapa penelitian juga menunjukkan potensi peran faktor genetik.',
      pencegahan:
          'Langkah-langkah pencegahan kanker kepala dan leher terutama berfokus pada modifikasi gaya hidup dan menghindari faktor risiko yang diketahui. Ini termasuk: berhenti merokok dan menghindari semua produk tembakau; membatasi atau menghindari konsumsi alkohol; mendapatkan vaksinasi HPV; praktik kebersihan mulut yang baik, termasuk menyikat gigi dan flossing secara teratur; menghindari paparan zat kimia berbahaya di tempat kerja dengan menggunakan alat pelindung diri yang sesuai; dan menjalani pemeriksaan rutin oleh dokter gigi dan dokter umum, terutama jika memiliki faktor risiko tinggi, untuk deteksi dini potensi masalah.',
      pengobatan:
          'Pengobatan kanker kepala dan leher sangat kompleks dan individual, tergantung pada lokasi spesifik kanker, stadium, jenis sel kanker, dan kesehatan umum pasien. Pilihan pengobatan utama meliputi pembedahan untuk mengangkat tumor dan jaringan di sekitarnya, termasuk kemungkinan pengangkatan kelenjar getah bening di leher jika kanker telah menyebar. Terapi radiasi (radioterapi) menggunakan sinar berenergi tinggi untuk membunuh sel kanker dan dapat digunakan sebagai pengobatan utama, sebelum atau sesudah operasi, atau untuk mengendalikan kanker yang tidak dapat diangkat. Kemoterapi menggunakan obat-obatan untuk membunuh sel kanker di seluruh tubuh dan sering dikombinasikan dengan radiasi (kemoradiasi) untuk meningkatkan efektivitasnya atau digunakan untuk mengobati kanker stadium lanjut. Terapi target menggunakan obat-obatan yang menargetkan protein atau jalur spesifik yang terlibat dalam pertumbuhan sel kanker, contohnya termasuk cetuximab. Imunoterapi adalah terapi yang membantu sistem kekebalan tubuh pasien untuk melawan sel kanker. Seringkali, kombinasi dari beberapa modalitas pengobatan ini diperlukan. Rehabilitasi setelah pengobatan, termasuk terapi bicara, menelan, dan dukungan psikologis, merupakan bagian penting dari perawatan untuk membantu pasien memulihkan fungsi dan kualitas hidup.',
      link:
          'https://www.gleneagles.com.sg/id/conditions-diseases/head-and-neck-cancer/symptoms-causes',
    ),
    Penyakit(
      nama: "Kanker Leher Metastatik",
      gejala: [12],
      deskripsi:
          "Kanker yang menyebar (metastasis) ke kelenjar getah bening di leher dari lokasi kanker primer di bagian tubuh lain. Kanker di area kepala dan leher (seperti mulut, tenggorokan, laring, tiroid) adalah sumber metastasis yang umum ke leher, tetapi kanker dari lokasi yang lebih jauh seperti paru-paru, payudara, atau perut juga dapat menyebar ke kelenjar getah bening leher.",
      gambar: 'images/KankerLeherMetastatik.png',
      penyebab:
          'Penyebab utama kanker leher metastatik adalah penyebaran sel-sel kanker dari tumor primer di bagian tubuh lain melalui sistem limfatik ke kelenjar getah bening di leher. Proses ini terjadi ketika sel-sel kanker terlepas dari tumor aslinya, masuk ke pembuluh limfe, dan terbawa ke kelenjar getah bening di leher, di mana mereka mulai tumbuh dan membentuk tumor sekunder (metastasis). Lokasi tumor primer yang paling sering bermetastasis ke leher adalah area kepala dan leher itu sendiri.',
      pencegahan:
          'Pencegahan kanker leher metastatik sangat bergantung pada pencegahan dan deteksi dini kanker primer di bagian tubuh lain. Langkah-langkah pencegahan umum untuk kanker meliputi menghindari faktor risiko yang diketahui (seperti merokok dan konsumsi alkohol berlebihan), menjalani gaya hidup sehat, dan melakukan skrining kanker yang direkomendasikan sesuai usia dan risiko individu. Deteksi dini kanker primer melalui pemeriksaan rutin dan kesadaran akan gejala dapat meningkatkan peluang keberhasilan pengobatan sebelum metastasis terjadi.',
      pengobatan:
          'Pengobatan kanker leher metastatik sangat bergantung pada lokasi dan ukuran metastasis di leher, lokasi dan stadium kanker primer, riwayat pengobatan sebelumnya, dan kesehatan umum pasien. Pilihan pengobatan dapat meliputi pembedahan untuk mengangkat kelenjar getah bening yang mengandung metastasis (diseksi leher), dan jika tumor primer di kepala dan leher juga belum diobati, pembedahan tumor primer mungkin dilakukan bersamaan atau terpisah. Terapi radiasi (radioterapi) dapat digunakan untuk mengobati area leher yang terkena, baik setelah pembedahan atau sebagai pengobatan utama jika pembedahan tidak memungkinkan, dan radiasi juga dapat ditujukan pada lokasi kanker primer. Kemoterapi menggunakan obat-obatan untuk membunuh sel kanker di seluruh tubuh, terutama jika ada metastasis di lokasi lain selain leher atau jika kanker primer adalah jenis yang responsif terhadap kemoterapi. Terapi target menggunakan obat-obatan yang menargetkan molekul spesifik pada sel kanker, dan imunoterapi adalah obat-obatan yang membantu sistem kekebalan tubuh pasien melawan kanker. Seringkali, kombinasi dari beberapa modalitas pengobatan ini digunakan. Identifikasi dan pengobatan tumor primer sangat penting dalam penanganan kanker leher metastatik. Tim medis akan bekerja sama untuk menentukan rencana pengobatan yang paling sesuai untuk setiap pasien.',
      link:
          'https://www.alodokter.com/metastasis-penyebaran-sel-kanker-yang-sulit-dikendalikan',
    ),
    Penyakit(
      nama: "Kanker Nasofaring",
      gejala: [5, 15],
      deskripsi:
          "Tumor ganas yang menyerang area nasofaring, yaitu bagian atas tenggorokan yang terletak di belakang hidung dan di atas langit-langit lunak. Kanker ini dapat tumbuh secara lokal dan menyebar ke kelenjar getah bening di leher, serta ke bagian tubuh yang lebih jauh.",
      gambar: 'images/KankerNasofaring.png',
      penyebab:
          'Penyebab pasti kanker nasofaring belum sepenuhnya diketahui, namun beberapa faktor risiko utama telah diidentifikasi. Infeksi virus Epstein-Barr (EBV) memiliki peran yang kuat dalam perkembangan banyak kasus kanker nasofaring, terutama jenis karsinoma sel skuamosa non-keratinisasi dan tidak terdiferensiasi. Faktor risiko lainnya meliputi konsumsi ikan asin yang diawetkan sejak usia dini (terutama di beberapa wilayah Asia Tenggara dan Tiongkok Selatan), riwayat keluarga dengan kanker nasofaring, dan paparan zat kimia tertentu di lingkungan atau pekerjaan.',
      pencegahan:
          'Karena peran pasti beberapa faktor risiko belum sepenuhnya dipahami, pencegahan primer kanker nasofaring mungkin sulit. Namun, beberapa langkah yang dapat dipertimbangkan meliputi: mengurangi konsumsi ikan asin yang diawetkan, terutama sejak usia muda; menghindari paparan zat karsinogenik di lingkungan dan pekerjaan; dan berpotensi, vaksinasi terhadap virus Epstein-Barr di masa depan jika vaksin yang efektif telah tersedia. Deteksi dini melalui kesadaran akan gejala dan pemeriksaan oleh dokter, terutama pada individu dengan faktor risiko tinggi, mungkin penting untuk meningkatkan hasil pengobatan.',
      pengobatan:
          'Pengobatan kanker nasofaring sangat bergantung pada stadium kanker, jenis histologi, dan kesehatan umum pasien. Karena lokasi nasofaring yang sulit diakses untuk pembedahan, radioterapi (terapi radiasi) seringkali menjadi pengobatan utama, terutama untuk stadium awal dan lokal lanjut. Kemoterapi biasanya diberikan bersamaan dengan radioterapi (kemoradiasi) untuk meningkatkan efektivitas pengobatan, terutama pada stadium yang lebih lanjut atau jika ada risiko penyebaran yang tinggi. Pembedahan mungkin dipertimbangkan untuk menangani kekambuhan lokal atau metastasis kelenjar getah bening di leher yang tidak responsif terhadap radioterapi. Terapi target dan imunoterapi juga mungkin menjadi pilihan dalam kasus tertentu, terutama pada kanker nasofaring yang kambuh atau metastasis. Rencana pengobatan akan disesuaikan dengan kondisi spesifik pasien oleh tim dokter yang terdiri dari ahli onkologi radiasi, ahli onkologi medis, dan ahli bedah kepala dan leher.',
      link:
          'https://www.pantai.com.my/id/medical-specialties/oncology/nasopharyngeal-cancer#:~:text=Kanker%20nasofaring%2C%20disebut%20juga%20sebagai,setiap%20100.000%20orang%20setiap%20tahun.',
    ),
    Penyakit(
      nama: "Kanker Tonsil",
      gejala: [7, 12],
      deskripsi:
          "Kanker yang berkembang pada tonsil, yaitu dua kelenjar getah bening yang terletak di bagian belakang tenggorokan. Kanker tonsil seringkali merupakan jenis karsinoma sel skuamosa dan semakin sering dikaitkan dengan infeksi Human Papillomavirus (HPV), terutama tipe 16.",
      gambar: 'images/KankerTonsil.png',
      penyebab:
          'Penyebab utama kanker tonsil meliputi infeksi Human Papillomavirus (HPV), terutama tipe 16, yang kini menjadi penyebab mayoritas kanker orofaringeal, termasuk kanker tonsil. Faktor risiko lain yang juga berperan adalah penggunaan tembakau (merokok dan mengunyah tembakau) dan konsumsi alkohol berlebihan. Kombinasi tembakau dan alkohol dapat meningkatkan risiko secara signifikan. Usia yang lebih tua dan riwayat keluarga dengan kanker kepala dan leher juga dapat menjadi faktor risiko.',
      pencegahan:
          'Pencegahan kanker tonsil melibatkan beberapa strategi. Vaksinasi HPV, yang direkomendasikan untuk remaja dan dewasa muda, dapat secara signifikan mengurangi risiko infeksi HPV dan kanker terkait HPV, termasuk kanker tonsil. Menghindari penggunaan tembakau dan membatasi konsumsi alkohol adalah langkah pencegahan penting lainnya. Menjaga kebersihan mulut yang baik juga dianjurkan. Pemeriksaan rutin oleh dokter gigi dan dokter umum dapat membantu dalam deteksi dini potensi masalah di area mulut dan tenggorokan.',
      pengobatan:
          'Pengobatan kanker tonsil sangat bergantung pada stadium kanker, ukuran tumor, penyebaran ke kelenjar getah bening, dan kesehatan umum pasien. Pilihan pengobatan utama meliputi pembedahan untuk mengangkat tumor tonsil dan mungkin juga kelenjar getah bening di leher (diseksi leher). Terapi radiasi (radioterapi) menggunakan sinar berenergi tinggi untuk membunuh sel kanker dan dapat digunakan sebagai pengobatan utama atau dikombinasikan dengan kemoterapi. Kemoterapi menggunakan obat-obatan untuk membunuh sel kanker, sering dikombinasikan dengan radiasi (kemoradiasi) untuk meningkatkan efektivitas, terutama pada stadium lanjut. Terapi target menggunakan obat-obatan yang menargetkan protein atau jalur spesifik pada sel kanker. Seringkali, kombinasi dari modalitas pengobatan ini digunakan. Pengobatan kanker tonsil terkait HPV seringkali memiliki prognosis yang lebih baik dibandingkan dengan kanker yang tidak terkait HPV. Tim medis akan merancang rencana pengobatan yang disesuaikan dengan kondisi spesifik pasien.',
      link:
          'https://www.siloamhospitals.com/en/informasi-siloam/artikel/tonsil-cancer-causes-symptoms-and-treatments',
    ),
    Penyakit(
      nama: "Laringitis",
      gejala: [1, 3, 14, 19, 37],
      deskripsi:
          "Peradangan pada laring (kotak suara) yang menyebabkan suara serak atau kehilangan suara. Laring mengandung pita suara yang bergetar untuk menghasilkan suara. Ketika laring meradang, pita suara membengkak dan terdistorsi, menghasilkan suara yang berbeda dari biasanya.",
      gambar: 'images/Laringitis.png',
      penyebab:
          'Penyebab laringitis dapat berupa infeksi virus (paling umum), seperti virus penyebab pilek atau flu. Penyebab lain termasuk penggunaan suara berlebihan (berteriak, bernyanyi terlalu keras atau lama), infeksi bakteri (lebih jarang), iritasi akibat asap rokok, alergi, inhalasi zat iritan, dan penyakit asam lambung (GERD) yang menyebabkan asam naik ke tenggorokan dan mengiritasi laring. Laringitis juga dapat dikaitkan dengan batuk kronis.',
      pencegahan:
          'Pencegahan laringitis tergantung pada penyebabnya. Untuk laringitis akibat infeksi, langkah-langkah pencegahan serupa dengan pencegahan infeksi saluran pernapasan, seperti sering mencuci tangan, menghindari kontak dekat dengan orang sakit, dan tidak berbagi barang pribadi. Untuk mencegah laringitis akibat penggunaan suara berlebihan, hindari berteriak atau bernyanyi terlalu keras dan berikan istirahat yang cukup pada suara Anda. Menghindari iritan seperti asap rokok dan polusi juga penting. Jika Anda memiliki GERD, mengelola kondisi tersebut dapat membantu mencegah laringitis. Menjaga hidrasi yang baik juga dapat membantu menjaga kelembaban laring.',
      pengobatan:
          'Pengobatan laringitis bertujuan untuk meredakan gejala dan mengatasi penyebabnya. Untuk laringitis virus, pengobatan biasanya bersifat suportif dan meliputi istirahat suara (menghindari berbicara atau berbisik), minum banyak cairan hangat, menggunakan humidifier untuk menjaga kelembaban udara, dan menghindari iritan seperti asap rokok. Obat pereda nyeri seperti parasetamol atau ibuprofen dapat membantu meredakan sakit tenggorokan. Laringitis bakteri memerlukan pengobatan dengan antibiotik yang diresepkan oleh dokter. Jika laringitis disebabkan oleh GERD, pengobatan akan fokus pada pengelolaan refluks asam. Dalam kasus laringitis kronis atau yang disebabkan oleh penggunaan suara berlebihan, terapi suara dengan seorang terapis suara dapat membantu mengajarkan teknik penggunaan suara yang lebih aman dan efisien.',
      link: 'https://www.alodokter.com/laringitis',
    ),
    Penyakit(
      nama: "Neuronitis Vestibularis",
      gejala: [10, 17],
      deskripsi:
          "Peradangan pada saraf vestibular, yaitu salah satu cabang saraf kranial kedelapan yang bertanggung jawab untuk mengirimkan informasi keseimbangan dari telinga bagian dalam ke otak. Peradangan ini dapat mengganggu sinyal keseimbangan, menyebabkan vertigo (sensasi berputar yang parah).",
      gambar: 'images/NeuronitisVestibularis.png',
      penyebab:
          'Penyebab pasti neuronitis vestibularis belum sepenuhnya dipahami, namun seringkali dikaitkan dengan infeksi virus, seperti virus herpes simpleks tipe 1 (HSV-1), yang dapat menjadi laten di ganglion vestibular. Infeksi virus lain atau peradangan autoimun juga diduga berperan dalam beberapa kasus. Jarang, neuronitis vestibularis dapat terjadi setelah infeksi bakteri.',
      pencegahan:
          'Karena penyebab pasti seringkali tidak diketahui atau terkait dengan infeksi virus yang sulit dicegah, tidak ada langkah pencegahan spesifik untuk neuronitis vestibularis. Namun, menjaga kesehatan umum dengan istirahat yang cukup, makan makanan bergizi, dan mengelola stres dapat membantu menjaga sistem kekebalan tubuh yang kuat.',
      pengobatan:
          'Pengobatan neuronitis vestibularis berfokus pada meredakan gejala akut dan membantu otak beradaptasi dengan perubahan fungsi vestibular (kompensasi vestibular). Pengobatan awal mungkin meliputi pemberian obat-obatan untuk mengurangi vertigo dan mual, seperti antihistamin (misalnya, dimenhydrinate, meclizine) atau antiemetik (misalnya, ondansetron, prochlorperazine). Kortikosteroid (seperti prednison) terkadang diresepkan untuk mengurangi peradangan saraf. Rehabilitasi vestibular, yang melibatkan latihan khusus untuk melatih otak mengatasi masalah keseimbangan, merupakan bagian penting dari pemulihan jangka panjang. Sebagian besar pasien akan mengalami perbaikan signifikan dalam beberapa minggu hingga bulan.',
      link: 'https://ai-care.id/kelainan-saraf/neuritis-vestibularis',
    ),
    Penyakit(
      nama: "Otosklerosis",
      gejala: [20, 35],
      deskripsi:
          "Pertumbuhan tulang abnormal di telinga tengah yang terutama mempengaruhi stapes (salah satu tulang pendengaran terkecil). Pertumbuhan tulang ini menghambat gerakan normal stapes, yang diperlukan untuk mengirimkan gelombang suara ke telinga bagian dalam, sehingga menyebabkan gangguan pendengaran konduktif.",
      gambar: 'images/Osteosklerosis.png',
      penyebab:
          'Penyebab pasti otosklerosis belum sepenuhnya dipahami, namun faktor genetik memainkan peran yang signifikan, dengan sekitar 50% kasus memiliki riwayat keluarga dengan kondisi tersebut. Faktor lain yang mungkin terlibat termasuk infeksi virus campak, gangguan autoimun, dan ketidakseimbangan hormon. Otosklerosis lebih sering terjadi pada wanita dan biasanya dimulai antara usia 10 dan 40 tahun.',
      pencegahan:
          'Karena faktor genetik merupakan predisposisi utama otosklerosis, tidak ada cara pencegahan yang diketahui. Namun, menghindari paparan kebisingan yang berlebihan dapat membantu melindungi pendengaran secara keseluruhan.',
      pengobatan:
          'Pengobatan otosklerosis bertujuan untuk memperbaiki atau memulihkan pendengaran. Pilihan pengobatan meliputi observasi jika gangguan pendengaran ringan, penggunaan alat bantu dengar untuk memperkuat suara yang masuk ke telinga, dan pembedahan (stapedektomi atau stapedotomi) di mana sebagian atau seluruh tulang stapes yang abnormal diangkat dan diganti dengan prostesis untuk memungkinkan getaran suara diteruskan ke telinga bagian dalam. Pembedahan seringkali berhasil dalam memperbaiki pendengaran, tetapi ada risiko kecil komplikasi.',
      link: 'https://www.alodokter.com/otosklerosis',
    ),
    Penyakit(
      nama: "Otitis Media Akut",
      gejala: [1, 6, 10, 32],
      deskripsi:
          "Infeksi telinga tengah yang terjadi tiba-tiba dan berlangsung dalam waktu singkat. Kondisi ini seringkali disebabkan oleh bakteri atau virus dan menyebabkan peradangan serta penumpukan cairan di ruang telinga tengah, yang dapat menimbulkan nyeri, demam, dan gangguan pendengaran.",
      gambar: 'images/OtitisMediaAkut.png',
      penyebab:
          'Penyebab utama otitis media akut adalah infeksi bakteri atau virus yang mencapai telinga tengah melalui tuba eustachius, saluran yang menghubungkan telinga tengah dengan bagian belakang tenggorokan. Infeksi saluran pernapasan atas (seperti pilek atau flu) sering mendahului otitis media akut karena dapat menyebabkan peradangan dan penyumbatan tuba eustachius. Bakteri yang paling sering terlibat adalah *Streptococcus pneumoniae* dan *Haemophilus influenzae*. Virus pernapasan juga dapat menyebabkan otitis media akut.',
      pencegahan:
          'Beberapa langkah dapat membantu mencegah otitis media akut, terutama pada anak-anak yang lebih rentan. Ini termasuk: praktik kebersihan yang baik seperti sering mencuci tangan untuk mencegah penyebaran infeksi; menghindari paparan asap rokok; memberikan ASI eksklusif selama 6 bulan pertama kehidupan bayi karena ASI mengandung antibodi yang dapat melindungi dari infeksi; memastikan anak-anak mendapatkan vaksinasi yang sesuai, termasuk vaksin pneumokokus dan influenza; dan mengelola alergi jika menjadi pemicu.',
      pengobatan:
          'Pengobatan otitis media akut bertujuan untuk meredakan nyeri dan mengatasi infeksi. Pendekatan pengobatan dapat meliputi: manajemen nyeri dengan obat pereda nyeri seperti parasetamol atau ibuprofen; sebagian kasus dapat sembuh sendiri tanpa antibiotik, terutama pada anak-anak yang lebih besar dan infeksi virus; antibiotik (biasanya amoksisilin) diresepkan oleh dokter jika infeksi bakteri dicurigai atau gejala tidak membaik setelah beberapa hari; dan dalam kasus otitis media berulang atau dengan penumpukan cairan yang persisten, dokter THT mungkin merekomendasikan miringotomi (sayatan kecil pada gendang telinga) untuk mengeluarkan cairan atau pemasangan tabung timpanostomi (tabung kecil) untuk membantu ventilasi telinga tengah.',
      link:
          'https://www.siloamhospitals.com/en/informasi-siloam/artikel/otitis-media-penyebab-gejala-dan-cara-mengobatinya',
    ),
    Penyakit(
      nama: "Meniere",
      gejala: [6, 10, 34, 36],
      deskripsi:
          "Gangguan telinga dalam kronis yang ditandai dengan episode vertigo (sensasi pusing berputar) yang parah, tinnitus (dering atau suara lain di telinga), gangguan pendengaran fluktuatif (terutama pada frekuensi rendah), dan rasa penuh atau tekanan di telinga. Gejala-gejala ini dapat terjadi dalam serangan yang berlangsung beberapa menit hingga beberapa jam.",
      gambar: 'images/Meniere.png',
      penyebab:
          'Penyebab pasti penyakit Meniere belum diketahui, namun diyakini terkait dengan adanya cairan endolimfa yang berlebihan di telinga bagian dalam (endolymphatic hydrops). Beberapa faktor yang mungkin berkontribusi termasuk faktor genetik, infeksi virus, gangguan autoimun, alergi, dan trauma kepala. Stres juga dapat menjadi pemicu serangan pada beberapa individu.',
      pencegahan:
          'Karena penyebab pasti penyakit Meniere tidak diketahui, tidak ada cara pencegahan yang spesifik. Namun, beberapa langkah dapat membantu mengelola gejala dan mengurangi frekuensi atau keparahan serangan, seperti: diet rendah garam untuk membantu mengurangi retensi cairan; menghindari kafein dan alkohol; berhenti merokok; mengelola stres melalui teknik relaksasi; dan tidur yang cukup.',
      pengobatan:
          'Pengobatan penyakit Meniere berfokus pada pengelolaan gejala akut dan pencegahan serangan di masa depan. Pengobatan saat serangan vertigo meliputi obat-obatan untuk meredakan mual dan muntah (antiemetik) dan obat penenang (sedatif). Pengobatan jangka panjang dapat meliputi: diet rendah garam dan diuretik untuk mengurangi retensi cairan; suntikan obat steroid ke telinga tengah; terapi rehabilitasi vestibular untuk membantu mengatasi masalah keseimbangan; dan dalam kasus yang parah dan tidak responsif terhadap pengobatan lain, pilihan bedah seperti dekompresi kantung endolimfatik, pemotongan saraf vestibular, atau labirintektomi (yang akan menyebabkan kehilangan pendengaran permanen pada telinga yang terkena) mungkin dipertimbangkan.',
      link: 'https://www.alodokter.com/penyakit-meniere',
    ),
    Penyakit(
      nama: "Tonsilitis",
      gejala: [1, 2, 3, 4, 7, 10],
      deskripsi:
          "Peradangan pada tonsil (amandel), dua kelenjar getah bening yang terletak di bagian belakang tenggorokan. Tonsilitis dapat disebabkan oleh infeksi virus atau bakteri, dan gejalanya yang paling umum adalah sakit tenggorokan.",
      gambar: 'images/Tonsilitis.png',
      penyebab:
          'Penyebab tonsilitis yang paling umum adalah infeksi virus, seperti virus penyebab pilek, flu, atau mononukleosis. Infeksi bakteri juga merupakan penyebab umum, terutama bakteri *Streptococcus pyogenes* (penyebab radang tenggorokan atau *strep throat*). Penyebab lain yang lebih jarang termasuk infeksi jamur atau iritasi akibat alergi atau polusi.',
      pencegahan:
          'Pencegahan tonsilitis yang disebabkan oleh infeksi melibatkan praktik kebersihan yang baik, seperti sering mencuci tangan, menghindari kontak dekat dengan orang yang sakit, tidak berbagi makanan atau minuman, dan menutup mulut saat batuk atau bersin. Tidak ada pencegahan khusus untuk tonsilitis yang disebabkan oleh alergi atau iritasi selain menghindari pemicunya.',
      pengobatan:
          'Pengobatan tonsilitis tergantung pada penyebabnya. Untuk tonsilitis virus, pengobatan biasanya bersifat suportif dan meliputi istirahat yang cukup, minum banyak cairan hangat, berkumur dengan air garam hangat untuk meredakan sakit tenggorokan, dan mengonsumsi obat pereda nyeri seperti parasetamol atau ibuprofen untuk mengurangi demam dan nyeri. Tonsilitis bakteri (radang tenggorokan) memerlukan pengobatan dengan antibiotik yang diresepkan oleh dokter untuk memberantas bakteri dan mencegah komplikasi seperti demam rematik. Penting untuk menghabiskan seluruh dosis antibiotik sesuai anjuran dokter. Tonsilektomi (pengangkatan amandel) mungkin dipertimbangkan pada kasus tonsilitis berulang yang sering terjadi dan mengganggu kualitas hidup.',
      link:
          'https://www.mayoclinic.org/diseases-conditions/tonsillitis/symptoms-causes/syc-20378479',
    ),
    Penyakit(
      nama: "Tumor Syaraf Pendengaran",
      gejala: [2, 20, 38],
      deskripsi:
          "Tumor jinak (non-kanker) yang tumbuh pada saraf kranial kedelapan, yang menghubungkan telinga bagian dalam ke otak. Saraf ini memiliki dua cabang utama: saraf koklea (untuk pendengaran) dan saraf vestibular (untuk keseimbangan). Tumor syaraf pendengaran, yang paling sering disebut schwannoma vestibular atau neuroma akustik, biasanya tumbuh lambat.",
      gambar: 'images/TumorSyarafPendengaran.png',
      penyebab:
          'Sebagian besar tumor syaraf pendengaran terjadi secara sporadis tanpa penyebab yang jelas. Namun, pada beberapa kasus, kondisi ini terkait dengan kelainan genetik yang disebut neurofibromatosis tipe 2 (NF2), di mana seseorang dapat mengembangkan tumor pada kedua saraf pendengaran. Tumor ini berkembang dari sel Schwann yang melapisi saraf.',
      pencegahan:
          'Karena sebagian besar tumor syaraf pendengaran terjadi secara sporadis, tidak ada cara pencegahan yang diketahui. Bagi individu dengan neurofibromatosis tipe 2, pemantauan rutin dan manajemen kondisi genetik adalah penting.',
      pengobatan:
          'Pengobatan tumor syaraf pendengaran tergantung pada ukuran tumor, tingkat pertumbuhan, gejala yang ditimbulkan, usia dan kesehatan umum pasien. Pilihan pengobatan meliputi pemantauan (observasi aktif) jika tumor kecil dan tidak menimbulkan gejala signifikan atau tumbuh sangat lambat, pembedahan untuk mengangkat tumor dengan tujuan mempertahankan fungsi pendengaran dan saraf wajah jika memungkinkan, meskipun risiko komplikasi tetap ada, dan radioterapi stereotaktik yang menggunakan radiasi dosis tinggi yang ditargetkan untuk menghentikan atau memperlambat pertumbuhan tumor. Pilihan pengobatan akan didiskusikan secara menyeluruh dengan pasien oleh tim dokter yang terdiri dari ahli bedah saraf, ahli THT (otolog), dan ahli onkologi radiasi.',
      link: 'https://www.alodokter.com/neuroma-akustik',
    ),

    Penyakit(
      nama: "Vertigo Postural",
      gejala: [17],
      deskripsi:
          "Vertigo yang dipicu oleh perubahan posisi kepala. Jenis vertigo postural yang paling umum adalah Benign Paroxysmal Positional Vertigo (BPPV), yang disebabkan oleh masalah pada telinga bagian dalam.",
      gambar: 'images/VertigoPostular.png',
      penyebab:
          'Penyebab vertigo postural yang paling sering adalah Benign Paroxysmal Positional Vertigo (BPPV). BPPV terjadi ketika kristal kalsium karbonat kecil (otoconia) di utrikulus, salah satu kantung di telinga bagian dalam yang mendeteksi gerakan linear, terlepas dan berpindah ke salah satu saluran setengah lingkaran. Kanalis semisirkularis sensitif terhadap gerakan rotasi kepala. Ketika kristal-kristal ini bergerak di dalam kanalis semisirkularis, mereka mengirimkan sinyal yang salah ke otak tentang posisi kepala, yang menyebabkan sensasi vertigo. Penyebab lain yang lebih jarang dari vertigo postural mungkin termasuk masalah pada sistem saraf pusat.',
      pencegahan:
          'Sebagian besar kasus BPPV tidak dapat dicegah karena seringkali terjadi secara tiba-tiba. Namun, beberapa tindakan pencegahan umum untuk menjaga kesehatan telinga bagian dalam dan mengurangi risiko gangguan keseimbangan meliputi menghindari trauma kepala dan mengelola kondisi medis lain yang dapat mempengaruhi keseimbangan.',
      pengobatan:
          'Pengobatan utama untuk BPPV, jenis vertigo postural yang paling umum, adalah serangkaian manuver reposisi kanal (seperti manuver Epley atau Semont) yang dilakukan oleh profesional kesehatan. Manuver ini bertujuan untuk memindahkan kembali kristal-kristal kalsium karbonat dari saluran setengah lingkaran ke utrikulus, di mana mereka tidak lagi menyebabkan gejala. Dalam beberapa kasus, latihan vestibular di rumah juga dapat diajarkan. Obat-obatan biasanya tidak efektif untuk mengobati BPPV, tetapi dapat digunakan untuk meredakan gejala mual dan pusing yang menyertainya. Jarang, pembedahan mungkin diperlukan untuk kasus BPPV yang parah dan tidak responsif terhadap terapi lain.',
      link: 'https://www.alodokter.com/bppv',
    ),
    Penyakit(
      nama: "Sinusitis Maksilaris",
      gejala: [1, 2, 4, 5, 8, 9, 11, 28, 33],
      deskripsi:
          "Peradangan pada sinus maksilaris, yaitu salah satu dari empat pasang rongga udara di tengkorak yang terletak di bawah pipi dan di atas gigi rahang atas. Peradangan ini sering disebabkan oleh infeksi virus, bakteri, atau jamur, atau oleh alergi.",
      gambar: 'images/SinusitisMaksilaris.png',
      penyebab:
          'Sinusitis maksilaris dapat disebabkan oleh beberapa faktor. Infeksi virus adalah penyebab paling umum dari sinusitis akut. Infeksi bakteri (seperti *Streptococcus pneumoniae*, *Haemophilus influenzae*, dan *Moraxella catarrhalis*) sering terjadi sebagai infeksi sekunder setelah infeksi virus. Alergi dapat menyebabkan peradangan pada saluran hidung dan sinus, yang dapat menyebabkan sinusitis alergi. Penyebab lain termasuk penyumbatan saluran sinus akibat polip hidung, deviasi septum, atau tumor; infeksi gigi yang menyebar ke sinus maksilaris (sinusitis odontogenik); dan iritan lingkungan seperti polusi udara dan asap rokok.',
      pencegahan:
          'Beberapa langkah dapat membantu mencegah sinusitis maksilaris, terutama yang terkait dengan infeksi: praktik kebersihan yang baik seperti sering mencuci tangan; menghindari kontak dekat dengan orang yang sakit; mengelola alergi dengan menghindari pemicu dan menggunakan obat-obatan yang diresepkan; menggunakan humidifier untuk menjaga kelembaban udara; menghindari paparan asap rokok dan polusi udara; dan mengobati infeksi saluran pernapasan atas dengan segera. Menjaga kesehatan gigi dan mulut juga penting untuk mencegah sinusitis odontogenik.',
      pengobatan:
          'Pengobatan sinusitis maksilaris tergantung pada penyebab dan tingkat keparahannya. Sinusitis virus biasanya akan membaik dengan sendirinya dalam beberapa minggu dengan perawatan suportif seperti istirahat yang cukup, minum banyak cairan, menghirup uap hangat, dan menggunakan semprotan hidung saline untuk membantu membersihkan saluran hidung. Obat pereda nyeri seperti parasetamol atau ibuprofen dapat membantu meredakan nyeri wajah dan demam. Sinusitis bakteri biasanya diobati dengan antibiotik yang diresepkan oleh dokter. Dekongestan oral atau semprotan hidung dapat membantu mengurangi pembengkakan pada saluran hidung dan sinus. Sinusitis alergi diobati dengan menghindari alergen dan menggunakan antihistamin atau semprotan hidung kortikosteroid. Untuk sinusitis kronis atau sinusitis yang disebabkan oleh penyumbatan struktural atau polip, dokter mungkin merekomendasikan kortikosteroid oral atau pembedahan sinus endoskopi untuk memperbaiki saluran sinus dan mengangkat polip atau jaringan abnormal lainnya.',
      link:
          'https://www.siloamhospitals.com/en/informasi-siloam/artikel/mengenal-sinusitis-maksilaris',
    ),
    Penyakit(
      nama: "Sinusitis Frontalis",
      gejala: [1, 2, 4, 5, 8, 9, 11, 18],
      deskripsi:
          "Peradangan pada sinus frontalis, yaitu sepasang rongga udara di dahi, tepat di atas mata. Peradangan ini dapat disebabkan oleh infeksi virus, bakteri, atau jamur, atau oleh alergi, yang menyebabkan penumpukan lendir dan nyeri di area dahi.",
      gambar: 'images/SinusitisFrontalis.png',
      penyebab:
          'Penyebab sinusitis frontalis serupa dengan jenis sinusitis lainnya. Infeksi virus seringkali menjadi pemicu awal, diikuti oleh infeksi bakteri sekunder dalam beberapa kasus. Alergi dapat menyebabkan peradangan yang menyumbat saluran sinus frontalis. Penyebab lain termasuk penyumbatan fisik akibat polip hidung atau deviasi septum, serta iritasi dari polusi udara atau asap rokok. Infeksi gigi juga dapat menyebar dan menyebabkan sinusitis frontalis, meskipun ini kurang umum.',
      pencegahan:
          'Langkah-langkah pencegahan sinusitis frontalis mirip dengan pencegahan sinusitis maksilaris. Ini meliputi praktik kebersihan yang baik, menghindari kontak dengan orang sakit, mengelola alergi, menggunakan humidifier, menghindari iritan, dan mengobati infeksi saluran pernapasan atas dengan segera. Menjaga kebersihan hidung dengan semprotan saline juga dapat membantu menjaga saluran sinus tetap bersih.',
      pengobatan:
          'Pengobatan sinusitis frontalis bertujuan untuk meredakan gejala dan mengatasi peradangan serta infeksi. Perawatan suportif seperti istirahat, hidrasi yang cukup, dan inhalasi uap hangat dapat membantu. Obat pereda nyeri seperti parasetamol atau ibuprofen dapat mengurangi nyeri dahi. Dekongestan oral atau semprotan hidung (digunakan dalam jangka pendek) dapat membantu membuka saluran sinus. Jika sinusitis bakteri dicurigai, dokter akan meresepkan antibiotik. Kortikosteroid hidung sering digunakan untuk mengurangi peradangan. Dalam kasus sinusitis kronis atau yang disebabkan oleh penyumbatan struktural, pembedahan sinus endoskopi mungkin diperlukan untuk memperbaiki drainase sinus frontalis.',
      link:
          'https://www.allianz.co.id/explore/mengenal-sinusitis-gejala-penyebab-cara-mengobati.html',
    ),
    Penyakit(
      nama: "Sinusitis Etmoidalis",
      gejala: [1, 2, 4, 5, 8, 9, 11, 18, 26, 27],
      deskripsi:
          "Peradangan pada sinus etmoid, yaitu sekelompok rongga udara yang terletak di antara mata dan di belakang pangkal hidung. Karena lokasinya yang berdekatan dengan mata dan otak, infeksi sinus etmoid memerlukan perhatian khusus.",
      gambar: 'images/SinusitisEtmoidalis.png',
      penyebab:
          'Penyebab sinusitis etmoidalis meliputi infeksi virus, bakteri, atau jamur, serta alergi yang menyebabkan peradangan pada lapisan sinus. Penyumbatan saluran sinus etmoid akibat polip hidung atau deviasi septum juga dapat berkontribusi. Infeksi saluran pernapasan atas seringkali menjadi pemicu awal. Karena kedekatannya dengan struktur penting di kepala, penyebaran infeksi dari sinus etmoid dapat menimbulkan komplikasi yang serius.',
      pencegahan:
          'Pencegahan sinusitis etmoidalis melibatkan langkah-langkah umum untuk mencegah infeksi saluran pernapasan, mengelola alergi, menghindari iritan, dan menjaga kebersihan hidung. Penggunaan humidifier dan semprotan hidung saline dapat membantu menjaga kelembaban dan kebersihan saluran hidung dan sinus.',
      pengobatan:
          'Pengobatan sinusitis etmoidalis bertujuan untuk meredakan peradangan, mengatasi infeksi, dan memastikan drainase sinus yang adekuat. Perawatan suportif seperti istirahat, hidrasi, dan inhalasi uap penting. Obat pereda nyeri dapat digunakan untuk mengatasi nyeri di antara mata atau sakit kepala. Dekongestan hidung (oral atau semprotan) dapat membantu membuka saluran sinus. Antibiotik akan diresepkan jika infeksi bakteri dicurigai. Kortikosteroid hidung adalah pengobatan lini pertama untuk mengurangi peradangan. Dalam kasus sinusitis etmoidalis kronis atau dengan komplikasi, pembedahan sinus endoskopi mungkin diperlukan untuk memperbaiki drainase sinus dan mengangkat jaringan abnormal. Mengingat potensi komplikasi, pemantauan dan penanganan oleh dokter sangat penting untuk sinusitis etmoidalis.',
      link:
          'https://www.siloamhospitals.com/en/informasi-siloam/artikel/mengenal-sinusitis-etmoid',
    ),
    Penyakit(
      nama: "Sinusitis Sfenoidalis",
      gejala: [1, 2, 4, 5, 6, 8, 9, 11, 12],
      deskripsi:
          "Peradangan pada sinus sfenoid, yaitu sepasang rongga udara yang terletak jauh di dalam tengkorak, di belakang mata dan di atas bagian belakang hidung. Karena lokasinya yang dekat dengan saraf optik dan kelenjar pituitari, sinusitis sfenoidalis dapat menimbulkan gejala yang unik dan berpotensi serius.",
      gambar: 'images/SinusitisSfenoidalis.png',
      penyebab:
          'Penyebab sinusitis sfenoidalis serupa dengan jenis sinusitis lainnya, termasuk infeksi virus, bakteri, atau jamur, serta alergi yang menyebabkan peradangan. Penyumbatan saluran sinus sfenoid akibat polip hidung, deviasi septum, atau tumor juga dapat berperan. Infeksi dari sinus lain dapat menyebar ke sinus sfenoid. Karena lokasinya yang terpencil dan drainasenya yang sulit, infeksi sinus sfenoidalis mungkin lebih sulit diobati dan berpotensi menyebabkan komplikasi.',
      pencegahan:
          'Langkah-langkah pencegahan sinusitis sfenoidalis mirip dengan jenis sinusitis lainnya: menjaga kebersihan, menghindari kontak dengan orang sakit, mengelola alergi, menggunakan humidifier, menghindari iritan, dan segera mengobati infeksi saluran pernapasan atas. Penggunaan semprotan hidung saline dapat membantu menjaga kebersihan saluran hidung.',
      pengobatan:
          'Pengobatan sinusitis sfenoidalis bertujuan untuk meredakan peradangan, mengatasi infeksi, dan memastikan drainase sinus. Perawatan suportif seperti istirahat dan hidrasi penting. Obat pereda nyeri dapat digunakan untuk mengatasi sakit kepala atau nyeri wajah. Dekongestan hidung (oral atau semprotan) dapat membantu membuka saluran sinus. Antibiotik akan diresepkan jika infeksi bakteri dicurigai. Kortikosteroid hidung atau oral sering digunakan untuk mengurangi peradangan. Karena potensi komplikasi yang serius akibat lokasi sinus sfenoidalis, dokter mungkin lebih agresif dalam pengobatan dan pemantauan. Dalam kasus sinusitis sfenoidalis kronis atau dengan komplikasi, pembedahan sinus endoskopi mungkin diperlukan untuk memperbaiki drainase sinus. Terkadang, drainase bedah langsung sinus sfenoidalis mungkin diperlukan.',
      link:
          'https://www-sinusitistreatmentnyc-com.translate.goog/blog/sphenoid-sinusitis-causes-symptoms-and-treatment/?_x_tr_sl=en&_x_tr_tl=id&_x_tr_hl=id&_x_tr_pto=sge#:~:text=Sinusitis%20%2C%20atau%20rinosinusitis%2C%20terjadi%20ketika,di%20belakang%20hidung%20dan%20mata.',
    ),
    Penyakit(
      nama: "Sakit Perut",
      gejala: [1, 2, 3, 4],
      deskripsi:
          "Kategori umum yang mencakup berbagai kondisi yang menyebabkan rasa tidak nyaman atau nyeri di area perut (abdomen). Sakit perut dapat disebabkan oleh berbagai masalah, mulai dari gangguan pencernaan ringan hingga kondisi medis yang lebih serius yang memerlukan perhatian medis segera.",
      gambar: 'images/SakitPerut.png',
      penyebab:
          'Penyebab sakit perut sangat beragam dan dapat diklasifikasikan berdasarkan sistem organ atau mekanisme terjadinya. Beberapa penyebab umum meliputi gangguan pencernaan (seperti asam lambung naik, perut kembung, sembelit, diare, keracunan makanan), infeksi (virus, bakteri, parasit yang mempengaruhi lambung, usus, atau organ lain di perut), peradangan (seperti gastritis, enteritis, kolitis, apendisitis), obstruksi (penyumbatan usus), penyakit kronis (seperti sindrom iritasi usus, penyakit Crohn, kolitis ulserativa), masalah pada organ lain di perut (seperti batu empedu, penyakit hati, pankreatitis), masalah pada organ di luar perut (seperti infeksi saluran kemih, pneumonia), nyeri otot atau saraf, dan kondisi psikologis (seperti stres atau kecemasan). Pada wanita, penyebab sakit perut juga bisa terkait dengan siklus menstruasi, kram menstruasi, atau masalah ginekologi lainnya.',
      pencegahan:
          'Pencegahan sakit perut sangat bergantung pada penyebab spesifiknya. Beberapa langkah umum yang dapat membantu mencegah sakit perut meliputi: menjaga kebersihan makanan dan minuman untuk menghindari keracunan makanan; mengonsumsi makanan yang sehat dan seimbang serta menghindari makanan pemicu gangguan pencernaan; minum air yang cukup untuk mencegah sembelit; berolahraga secara teratur; mengelola stres; dan mempraktikkan kebiasaan buang air besar yang sehat. Untuk kondisi kronis, mengikuti rencana pengobatan yang direkomendasikan oleh dokter sangat penting.',
      pengobatan:
          'Pengobatan sakit perut juga sangat bervariasi tergantung pada penyebabnya. Untuk sakit perut ringan akibat gangguan pencernaan, langkah-langkah seperti istirahat, menghindari makanan padat, minum cairan bening, dan penggunaan obat bebas seperti antasida atau pereda nyeri ringan mungkin cukup. Namun, sakit perut yang parah, berlangsung lama, atau disertai gejala lain seperti demam tinggi, muntah terus-menerus, perdarahan, atau perut kaku memerlukan perhatian medis segera untuk diagnosis dan pengobatan yang tepat. Pengobatan mungkin melibatkan obat-obatan (seperti antibiotik untuk infeksi bakteri, antasida untuk masalah asam lambung, obat anti-inflamasi), perubahan gaya hidup dan diet, atau bahkan pembedahan dalam kasus yang lebih serius seperti apendisitis atau obstruksi usus. Diagnosis yang akurat adalah kunci untuk penanganan yang efektif.',
      link: 'https://www.alodokter.com/sakit-perut',
    ),
  ];

  void diagnosa() {
    if (selectedGejala.isEmpty) {
      _showAlert(
        "Peringatan",
        "Silakan pilih minimal satu gejala terlebih dahulu.",
        true,
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
      _showResultsDialog(top5, hasilDiagnosa);
    } else {
      _showAlert(
        "Hasil Diagnosa",
        "Tidak ditemukan penyakit yang cocok dengan gejala yang dipilih.",
        false,
      );
    }
  }

  void _showAlert(String title, String content, bool isWarning) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(
              title,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                color: isWarning ? accentColor : primaryColor,
              ),
            ),
            content: Text(
              content,
              style: GoogleFonts.nunito(color: textPrimaryColor),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "OK",
                  style: GoogleFonts.montserrat(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  void _showResultsDialog(
    List<dynamic> top5,
    List<Map<String, Object>> allResults,
  ) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(
              "Hasil Diagnosa",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                color: primaryColor,
                fontSize: 20,
              ),
            ),
            content: Container(
              width: double.maxFinite,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Kemungkinan penyakit berdasarkan gejala yang dipilih:",
                    style: GoogleFonts.nunito(
                      color: textSecondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: top5.length,
                      separatorBuilder:
                          (context, index) =>
                              Divider(height: 1, color: Colors.grey.shade200),
                      itemBuilder: (context, index) {
                        final item = top5[index];
                        final p = item['penyakit'] as Penyakit;
                        final persen = item['persen'] as double;
                        final matchColor =
                            persen > 75
                                ? Colors.red.shade700
                                : persen > 50
                                ? Colors.orange
                                : persen > 25
                                ? Colors.amber.shade700
                                : Colors.green;

                        return Card(
                          elevation: 0,
                          color: index == 0 ? Colors.blue.shade50 : cardColor,
                          margin: EdgeInsets.symmetric(vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color:
                                  index == 0
                                      ? primaryColor
                                      : Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    p.nama,
                                    style: GoogleFonts.montserrat(
                                      fontWeight:
                                          index == 0
                                              ? FontWeight.bold
                                              : FontWeight.w600,
                                      color: textPrimaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: matchColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "${persen.toStringAsFixed(1)}%",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      color: matchColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              "Klik untuk detail",
                              style: GoogleFonts.nunito(
                                color: textSecondaryColor,
                                fontSize: 12,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: primaryColor,
                            ),
                            onTap: () {
                              Navigator.pop(context); // Tutup dialog dulu
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => DetailPenyakitPage(penyakit: p),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Kembali",
                  style: GoogleFonts.montserrat(color: textSecondaryColor),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => DetailDiagnosaPage(hasilDiagnosa: allResults),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Lihat Semua",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Diagnosa Penyakit THT',
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
          // Header section
          Container(
            color: primaryColor,
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deteksi Dini Penyakit THT',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Pilih gejala yang Anda alami untuk diagnosa awal',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          // Counter for selected symptoms
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 3),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  'Gejala dipilih: ',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: textPrimaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color:
                        selectedGejala.isEmpty
                            ? Colors.grey.shade200
                            : primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '${selectedGejala.length}',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color:
                          selectedGejala.isEmpty
                              ? Colors.grey.shade700
                              : primaryColor,
                    ),
                  ),
                ),
                Spacer(),
                if (selectedGejala.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedGejala.clear();
                      });
                    },
                    child: Text(
                      'Reset',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: accentColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // List of symptoms organized by category
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              physics: BouncingScrollPhysics(),
              children: [
                ...gejalaByCategory.entries.map((category) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 4,
                        ),
                        child: Row(
                          children: [
                            Text(
                              category.key,
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Divider(
                                color: primaryColor.withOpacity(0.2),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 0,
                        margin: EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: category.value.length,
                          separatorBuilder:
                              (context, index) => Divider(
                                height: 1,
                                indent: 16,
                                endIndent: 16,
                                color: Colors.grey.shade100,
                              ),
                          itemBuilder: (context, index) {
                            final gejalaId = category.value[index];
                            final gejalaName = gejalaMap[gejalaId]!;
                            final isSelected = selectedGejala.contains(
                              gejalaId,
                            );

                            return CheckboxListTile(
                              title: Text(
                                gejalaName,
                                style: GoogleFonts.nunito(
                                  fontSize: 15,
                                  color:
                                      isSelected
                                          ? primaryColor
                                          : textPrimaryColor,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                ),
                              ),
                              value: isSelected,
                              activeColor: primaryColor,
                              checkColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              dense: true,
                              controlAffinity: ListTileControlAffinity.leading,
                              secondary:
                                  isSelected
                                      ? Icon(
                                        Icons.check_circle_outline,
                                        color: primaryColor,
                                        size: 20,
                                      )
                                      : null,
                              onChanged: (val) {
                                setState(() {
                                  val!
                                      ? selectedGejala.add(gejalaId)
                                      : selectedGejala.remove(gejalaId);
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
                SizedBox(height: 70), // Extra space for the floating button
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: selectedGejala.isNotEmpty ? 1.0 : 0.7,
        duration: Duration(milliseconds: 200),
        child: FloatingActionButton.extended(
          onPressed: diagnosa,
          backgroundColor: primaryColor,
          icon: Icon(Icons.medical_services_outlined, color: Colors.white),
          label: Text(
            'Diagnosa Sekarang',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
