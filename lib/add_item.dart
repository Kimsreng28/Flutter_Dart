import 'package:flutter/material.dart';
import 'package:tasklis_app/func.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();

  static const routeName = '/add';
}

class _AddItemState extends State<AddItem> with Func {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ItemArguments;
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Item - ${args.listname} List",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: ,
    );
  }
}

class ItemArguments {
  final String listid;
  final String listname;

  ItemArguments({required this.listid, required this.listname});
}
