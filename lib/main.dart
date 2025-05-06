import 'package:flutter/material.dart';
import 'package:sistem_pakar/pages/diagnosa_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DiagnosaPage(), debugShowCheckedModeBanner: false);
  }
}
