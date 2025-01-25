import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:tasklis_app/func.dart';

class Lists extends StatefulWidget {
  const Lists({super.key});

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> with Func {
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
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ],
        ),
        body: FutureBuilder(
            future: getLists(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: 5 + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 5) {
                      return ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text('Add List'));
                    }
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.list),
                        title: Text('List $index'),
                        trailing: const Icon(Icons.arrow_right),
                      ),
                    );
                  },
                );
              } else {
                return EmptyWidget(
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
                );
              }
            }));
  }
}
