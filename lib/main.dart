import 'package:flutter/material.dart';
import 'package:tasklis_app/landing.dart';
import 'package:tasklis_app/lists.dart';
import 'package:tasklis_app/signin.dart';
import 'package:tasklis_app/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskList Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const Landing(),
        "/signin": (context) => const SignIn(),
        "/signup": (context) => const SignUp(),
        "/lists": (context) => const Lists(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
