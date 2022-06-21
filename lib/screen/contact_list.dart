import 'package:flutter/material.dart';
import 'package:text_me/database/DAO/contact_dao.dart';
import 'package:text_me/model/contact.dart';
import 'package:text_me/screen/contact_form.dart';
import 'package:text_me/screen/sendmessage.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactDao _contactDao = ContactDao();

  @override
  Widget build(BuildContext context) {
    //contactList.add();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => const ContactForm(),
              ))
              .then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'Contact List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<List<Contact>>(
        future: _contactDao.findAll(),
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
                final List<Contact> contactList = snapshot.data!;
                return ListView.builder(
                    itemCount: contactList.length,
                    itemBuilder: (context, index) {
                      final contact = contactList[index];
                      return Dismissible(
                        onDismissed: (direction) =>
                            _contactDao.deleteItem(contactList[index].id),
                        key: ValueKey<int>(contactList[index].id),
                        background: Container(
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          SendMessage(contact: contact))));
                            },
                            title: Text(
                              contact.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(contact.email),
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
