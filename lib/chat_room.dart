import 'package:flutter/material.dart';
import 'package:tasklis_app/constant.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController messagecontroller = TextEditingController();
  List<Widget> messages = [];
  WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(ws));

  @override
  void initState() {
    super.initState();
    channel.stream.listen((message) {
      getMessage(message, Colors.blue);
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50, right: 20, left: 20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: messages,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        controller: messagecontroller,
                        decoration: const InputDecoration(
                            hintText: "Enter your message"),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            getMessage(messagecontroller.text, Colors.black54);
                          });
                          channel.sink.add(messagecontroller.text);
                          messagecontroller.clear();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blue,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getMessage(String message, Color clr) {
    setState(() {
      messages.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: clr, fontWeight: FontWeight.bold),
        ),
      ));
    });
  }
}
