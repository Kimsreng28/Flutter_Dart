import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:tasklis_app/func.dart';
import 'package:tasklis_app/viewlist.dart';

class Lists extends StatefulWidget {
  const Lists({super.key});

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> with Func {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Lists',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, "/settings");
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              Navigator.pushNamed(context, ViewList.routeName,
                  arguments:
                      ViewArguments(listName: "All Items", id: "", all: true));
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: getLists(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EmptyWidget(
                          image: null,
                          packageImage: PackageImage.Image_4,
                          title: 'No Lists',
                          subTitle: 'You have no lists yet',
                          titleTextStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue),
                          subtitleTextStyle: const TextStyle(
                              fontSize: 14, color: Colors.green),
                        ),
                        newList(context)
                      ],
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    var entryList = snapshot.data!.entries.toList();
                    if (index == snapshot.data!.length) {
                      return newList(context);
                    }
                    return Card(
                      child: ListTile(
                        onTap: () {
                          // logic
                          Navigator.pushNamed(context, ViewList.routeName,
                              arguments: ViewArguments(
                                  listName:
                                      entryList[index].value["name"] ?? "",
                                  id: entryList[index].value["id"] ?? ""));
                        },
                        leading: const Icon(Icons.list),
                        title: Text(entryList[index].value["name"] ?? ""),
                        trailing: const Icon(Icons.arrow_right),
                      ),
                    );
                  },
                );
              }
            } else {
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: EmptyWidget(
                    image: null,
                    packageImage: PackageImage.Image_4,
                    title: 'No Lists',
                    subTitle: 'You have no lists yet',
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
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), label: 'Recipe'),
          BottomNavigationBarItem(
              icon: Icon(Icons.file_download_sharp), label: 'Files'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble), label: 'Chat Room'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        unselectedIconTheme: const IconThemeData(size: 15),
        onTap: (value) {},
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 1) {
      Navigator.pushNamed(context, "/recipe");
    } else if (_selectedIndex == 2) {
      Navigator.pushNamed(context, "/file");
    } else {
      Navigator.pushNamed(context, "/chat");
    }
  }

  ElevatedButton newList(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  icon: const CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                  content: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: 'Add Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      )),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            createList(nameController.text);
                            Navigator.pop(context);
                            nameController.clear();
                            setState(() {});
                          }
                        },
                        child: const Text('Add')),
                  ],
                );
              });
        },
        icon: const Icon(Icons.add),
        label: const Text('Add new List'));
  }
}
