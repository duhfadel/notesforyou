import 'package:flutter/material.dart';
import 'package:text_me/database/DAO/message_dao.dart';
import 'package:text_me/model/message.dart';
import 'package:text_me/screen/full_message.dart';

class MessageList extends StatefulWidget {
  MessageList({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final List<Message> messageList = [];
  MessageDao _messageDao = MessageDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('You saved these notes!'),
      ),
      body: FutureBuilder<List<Message>>(
        future: _messageDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.data != null) {
                final List<Message> messageList = snapshot.data!;
                return ListView.builder(
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      final message = messageList[index];
                      return Dismissible(
                        onDismissed: (direction) =>
                            _messageDao.deleteItem(messageList[index].id),
                        key: ValueKey<int>(messageList[index].id),
                        background: Container(
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: ((context) => FullMessage(message: message))));
                            },
                            title: Text('Title: ${message.title}'),
                            subtitle: Text(
                              'To: ${message.contactName}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    });
              }
          }
          return const Text('You dont have any contact');
        },
      ),
    );
  }
}
