import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:tasklis_app/add_item.dart';
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
          title: Text(args.listName,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, AddItem.routeName,
                    arguments: ItemArguments(
                        listid: args.id, listname: args.listName));
              },
            ),
          ],
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: getItemsByList(args.id, context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: EmptyWidget(
                      image: null,
                      packageImage: PackageImage.Image_4,
                      title: 'No Items',
                      subTitle: 'You have no Items yet',
                      titleTextStyle: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                      subtitleTextStyle:
                          const TextStyle(fontSize: 14, color: Colors.green),
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                            leading:
                                Checkbox(value: false, onChanged: (value) {}),
                            title: Text(
                              'Item $index',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Description $index',
                                style: const TextStyle(fontSize: 13)),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {},
                            )),
                      );
                    });
              }
            } else {
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: EmptyWidget(
                    image: null,
                    packageImage: PackageImage.Image_4,
                    title: 'No Items',
                    subTitle: 'You have no Items yet',
                    titleTextStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),
                    subtitleTextStyle:
                        const TextStyle(fontSize: 14, color: Colors.green),
                  ),
                ),
              );
            }
          },
        ));
  }
}

class ViewArguments {
  final String listName;
  final String id;
  final bool? all;

  ViewArguments({required this.listName, required this.id, this.all});
}