import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lookgood_cb007942/login_page.dart';
import 'package:lookgood_cb007942/services/authservice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(accentColor: Color(0xFF00AF19)),
      home: AuthService().handleauth(),
    );
  }
}
