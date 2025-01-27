import 'package:flutter/material.dart';
import 'package:tasklis_app/func.dart';

class FileUpload extends StatefulWidget {
  const FileUpload({super.key});

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> with Func {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Upload',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.upload_file),
                  onPressed: () {},
                  label: const Text("Click to upload file"),
                ),
              ),
              const Text("My file",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.file_copy),
                  title: Text("file name"),
                  trailing: Icon(Icons.arrow_right_alt_outlined),
                ),
              ),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.file_copy),
                  title: Text("file name"),
                  trailing: Icon(Icons.arrow_right_alt_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
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
}
