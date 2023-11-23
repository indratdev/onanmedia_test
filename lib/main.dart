import 'package:flutter/material.dart';
import 'package:onanmedia_test/presentation/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // color: Color(0xFF21ABA5),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        color: Color(0xFF21ABA5),
      )),
      home: LoginScreen(),
    );
  }
}
