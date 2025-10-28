import 'package:flutter/material.dart';
import 'login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UBSafeStep',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF862334),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF862334),
          secondary: const Color(0xFFFFC553),
          background: Colors.grey[50],
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF862334),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          shadowColor: Colors.black26,
        ),
        fontFamily: 'Poppins',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyLarge: const TextStyle(color: Color(0xFF222222)),
          bodyMedium: const TextStyle(color: Color(0xFF222222)),
          titleLarge: const TextStyle(color: Color(0xFF862334)),
          titleMedium: const TextStyle(color: Color(0xFF862334)),
        ),
      ),
      home: const LoginPage(),
    );
  }
}