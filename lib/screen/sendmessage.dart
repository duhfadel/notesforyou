import 'package:flutter/material.dart';
import 'package:text_me/database/DAO/message_dao.dart';
import 'package:text_me/model/contact.dart';
import '../model/message.dart';

class SendMessage extends StatelessWidget {
  SendMessage({
    Key? key,
    required this.contact,
  }) : super(key: key);
  final Contact contact;

  final MessageDao messageDao = MessageDao();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To: ${contact.name}'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Title'),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      maxLines: 10,
                      controller: _textController,
                      decoration:
                          InputDecoration(labelText: 'Write your message!'),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  _sendMessage(context);
                },
                child: Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sendMessage(BuildContext context) {
    Message newMessage = Message(
        id: 0,
        title: _titleController.text,
        text: _textController.text,
        contactName: contact.name,
        contactEmail: contact.email);
    print(newMessage);
    messageDao.save(newMessage).then((id) => Navigator.pop(context));
  }
}
