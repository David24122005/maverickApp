import 'package:flutter/material.dart';
import 'package:maverickapp/screens/LoginScreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final _storage = const FlutterSecureStorage();
  final url = "http://localhost:5000/api";

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _storage.write(key: "baseUrl", value: url);

    return MaterialApp(
      title: 'Maverick App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
