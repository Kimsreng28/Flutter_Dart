import 'package:flutter/material.dart';
import 'package:tasklis_app/add_item.dart';
import 'package:tasklis_app/chat_room.dart';
import 'package:tasklis_app/file.dart';
import 'package:tasklis_app/landing.dart';
import 'package:tasklis_app/lists.dart';
import 'package:tasklis_app/recipe.dart';
import 'package:tasklis_app/signin.dart';
import 'package:tasklis_app/signup.dart';
import 'package:tasklis_app/viewlist.dart';

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
        ViewList.routeName: (context) => const ViewList(),
        AddItem.routeName: (context) => const AddItem(),
        "/recipe": (context) => const Recipe(),
        "/file": (context) => const FileUpload(),
        "/chat": (context) => const ChatRoom(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
