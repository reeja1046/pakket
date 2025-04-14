import 'package:flutter/material.dart';
import 'package:pakket/view/home/home.dart';
import 'package:pakket/view/product/productdetail.dart';
import 'package:pakket/view/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pakket',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
