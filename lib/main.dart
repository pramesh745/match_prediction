import 'package:flutter/material.dart';
import 'package:match_prediction_app/screens/auth/login_page.dart';
import 'package:match_prediction_app/screens/auth/register_page.dart';
import 'package:match_prediction_app/services/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_)=> AuthProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
      ),
    );
  }
}

