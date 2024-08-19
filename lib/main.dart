import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Roti',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: HomeScreen(),
    );
  }
}
