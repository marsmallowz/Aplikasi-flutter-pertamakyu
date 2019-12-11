import 'package:cobaaaa_dulu/app/landing_page.dart';
import 'package:cobaaaa_dulu/services/auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coba Aja Dulu',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
