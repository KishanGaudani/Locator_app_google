import 'package:flutter/material.dart';
import 'package:locator_pr/screens/views/firstpage.dart';
import 'package:locator_pr/screens/views/home_screen.dart';
import 'package:locator_pr/screens/views/map.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'second': (context) => const secondPage(),
        'map': (context) => const GMap(),
      },
    ),
  );
}
