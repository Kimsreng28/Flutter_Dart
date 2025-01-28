import 'package:flutter/material.dart';
import 'package:tasklis_app/func.dart';
import 'package:tasklis_app/main.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> with Func {
  final TextEditingController oldpassword = TextEditingController();
  final TextEditingController newpassword = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create a new password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                  "Your new password must be different from your previous password"),
              TextFormField(
                controller: oldpassword,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Enter your old password",
                    suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            oldpassword.clear();
                          });
                        },
                        icon: const Icon(Icons.clear))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter old password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: newpassword,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Enter your new password",
                    suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            newpassword.clear();
                          });
                        },
                        icon: const Icon(Icons.clear))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: confirmpassword,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Enter confirm password",
                    suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            confirmpassword.clear();
                          });
                        },
                        icon: const Icon(Icons.clear))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm password';
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (newpassword.text == confirmpassword.text) {
                      updateUserUsingBasic(
                          customProvider.user['id'],
                          customProvider.user['name'],
                          customProvider.user['username'],
                          newpassword.text,
                          oldpassword.text,
                          context);
                      Navigator.pushNamed(context, "/signin");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "New Password and Confirm Password doesn't match")));
                    }
                  },
                  child: const Text("Update"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
