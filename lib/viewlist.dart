import 'package:flutter/material.dart';
import 'package:tasklis_app/func.dart';

class ViewList extends StatefulWidget {
  const ViewList({super.key});

  @override
  State<ViewList> createState() => _ViewListState();

  static const routeName = '/view';
}

class _ViewListState extends State<ViewList> with Func {
  bool editable = false;
  final TextEditingController nameController = TextEditingController();
  Map<int, bool> update = {};
  Map<int, TextEditingController> itemnameControllers = {};
  Map<int, TextEditingController> itemdescriptionControllers = {};
  Map<int, bool> completed = {};

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ViewArguments;
    nameController.text = args.listName;

    return Scaffold(
        appBar: AppBar(
      title: const Text(""),
      centerTitle: false,
      actions: [],
    ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index){
        return Card(
          child: ListTile(
            
          ),
        )
      }),
    );
  }
}

class ViewArguments {
  final String listName;
  final String id;
  final bool? all;

  ViewArguments({required this.listName, required this.id, this.all});
}
