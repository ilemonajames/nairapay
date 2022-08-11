import 'package:flutter/material.dart';
import 'package:nairapay/Pages/Home.dart';
import 'package:nairapay/Pages/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Helpers/Utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          fontFamily: 'Hero New'),
      home: const LoginPage(),
    );
  }
}
