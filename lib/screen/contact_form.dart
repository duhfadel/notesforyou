import 'package:flutter/material.dart';
import 'package:text_me/database/DAO/contact_dao.dart';
import 'package:text_me/model/contact.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final ContactDao _contactDao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Fill the form! :)',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 15),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Any other information',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Colors.black, width: 1)),
            child: InkWell(
              onTap: () {
                final String name = _nameController.text;
                final String email = _emailController.text;
                final Contact newContact =
                    Contact(id: 0, name: name, email: email);
                _contactDao
                    .save(newContact)
                    .then((id) => Navigator.pop(context));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                  height: 50,
                  width: double.maxFinite,
                  child: const Center(
                      child: Text(
                    'Add New Contact',
                    style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ))),
            ),
          )
        ]),
      ),
    );
  }
}
