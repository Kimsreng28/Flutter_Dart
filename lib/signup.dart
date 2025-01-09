import 'package:flutter/material.dart';
import 'package:tasklis_app/func.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with Func {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: Column(children: [
                Hero(
                    tag: "landing",
                    child: Image.asset(
                      "assets/task.jpg",
                      width: 300,
                    )),
                TextFormField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(hintText: "Enter your name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: usernameController,
                  decoration:
                      const InputDecoration(hintText: "Enter your username"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Enter your password",
                      suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordController.clear();
                            });
                          },
                          icon: const Icon(Icons.clear))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          createUserUsingBasic(
                              nameController.text,
                              usernameController.text,
                              passwordController.text,
                              context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      child: const Text("Sign Up"),
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/signin");
                    },
                    child: const Text("Already have an account! Sign In"))
              ])),
        ),
      ),
    );
  }
}
