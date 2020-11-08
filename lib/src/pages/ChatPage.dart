import 'package:besafehealthcare/src/models/ChatModel.dart';
import 'package:besafehealthcare/src/models/Message.dart';
import 'package:besafehealthcare/src/models/User.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ChatPage extends StatefulWidget {
  final User user;
  ChatPage(this.user);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();

  Widget buildSingleMessage(Message message) {
    return Container(
      alignment: message.senderID == widget.user.chatID
          ? Alignment.centerLeft
          : Alignment.centerRight,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: Text(message.text),
    );
  }

  Widget buildChatList() {
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {
        List<Message> messages =
            model.getMessagesForChatID(widget.user.chatID);

        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              return buildSingleMessage(messages[index]);
            },
          ),
        );
      },
    );
  }

  Widget buildChatArea() {
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {
        return Container(
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: textEditingController,
                ),
              ),
              SizedBox(width: 10.0),
              FloatingActionButton(
                onPressed: () {
                  model.sendMessage(
                      textEditingController.text, widget.user.chatID);
                  textEditingController.text = '';
                },
                elevation: 0,
                child: Icon(Icons.send),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
      ),
      body: ListView(
        children: <Widget>[
          buildChatList(),
          buildChatArea(),
        ],
      ),
    );
  }
}