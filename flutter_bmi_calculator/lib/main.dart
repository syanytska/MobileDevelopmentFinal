import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bmi_controller.dart';
import 'screens/user/loginPage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BmiController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const LoginPage(), // 👈 default page now is login
    );
  }
}
