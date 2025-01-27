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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              if (editable) {
                setState(() {
                  editable = false;
                });
              } else {
                Navigator.of(context)
                    .pushNamed("/lists")
                    .then((value) => {setState(() => {})});
              }
            },
          ),
          title: (editable)
              ? TextField(
                  controller: nameController,
                  cursorColor: Colors.white,
                )
              : Text(args.listName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
          centerTitle: false,
          actions: (editable)
              ? [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              icon: const CircleAvatar(
                                radius: 30,
                                child: Icon(Icons.delete, size: 30),
                              ),
                              content: const Text(
                                  "Do you want to delete this list?"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      deleteList(args.id);
                                      Navigator.of(context)
                                          .pushNamed("/lists")
                                          .then(
                                              (value) => {setState(() => {})});
                                    },
                                    child: const Text("Yes")),
                                OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        editable = false;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text("No")),
                              ],
                            );
                          });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () {
                      updateList(args.id, nameController.text.toString());
                      setState(() {
                        editable = false;
                      });
                      Navigator.pushNamed(context, "/lists")
                          .then((value) => setState(() {}));
                    },
                  ),
                ]
              : (args.all == true)
                  ? null
                  : [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AddItem.routeName,
                            arguments: ItemArguments(
                                listid: args.id, listname: args.listName),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            editable = true;
                          });
                        },
                      ),
                    ],
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: (args.all == true)
              ? getItems(context)
              : getItemsByList(args.id, context),
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
                          const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var entryList = snapshot.data!.entries.toList();
                      itemnameControllers.putIfAbsent(
                          index, () => TextEditingController());
                      itemdescriptionControllers.putIfAbsent(
                          index, () => TextEditingController());
                      update.putIfAbsent(index, () => false);

                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          deleteItem(entryList[index].value['id']);
                          setState(() {});
                        },
                        background: Container(
                          color: Colors.red,
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.delete, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  'Delete Item',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: Card(
                          child: ListTile(
                              leading: Checkbox(
                                  value: entryList[index].value['status'],
                                  onChanged: (value) {
                                    updateItem(
                                        entryList[index].value['id'],
                                        args.id,
                                        entryList[index].value['name'],
                                        entryList[index].value['description'],
                                        value!);
                                    setState(() {});
                                  }),
                              title: (update[index]!)
                                  ? TextField(
                                      controller: itemnameControllers[index],
                                    )
                                  : Text(
                                      entryList[index].value['name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                              subtitle: (update[index]!)
                                  ? TextField(
                                      controller:
                                          itemdescriptionControllers[index],
                                    )
                                  : Text(entryList[index].value['description'],
                                      style: const TextStyle(fontSize: 13)),
                              trailing: (update[index]!)
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.save,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        updateItem(
                                            entryList[index].value['id'],
                                            args.id,
                                            itemnameControllers[index]!.text,
                                            itemdescriptionControllers[index]!
                                                .text,
                                            completed[index] ?? false);
                                        setState(() {
                                          update[index] = false;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          update[index] = true;
                                          itemnameControllers[index]!.text =
                                              entryList[index].value["name"];
                                          itemdescriptionControllers[index]!
                                                  .text =
                                              entryList[index]
                                                  .value["description"];
                                        });
                                      },
                                    )),
                        ),
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
