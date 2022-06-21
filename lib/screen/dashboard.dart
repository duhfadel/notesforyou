import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:text_me/screen/contact_list.dart';
import 'package:text_me/screen/message_sent.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  final style = const TextStyle(
    fontSize: 50,
    color: Colors.amber,
  );

  final style2 = const TextStyle(
    fontSize: 50,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                ),
                Positioned(
                  top: 0,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black),
                            color: Colors.white,
                          ),
                          height: 180,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.chat,
                                  size: 70,
                                ),
                                BorderedText(
                                  strokeWidth: 5.0,
                                  strokeColor: Colors.black,
                                  child: Text(
                                    'Notes for',
                                    style:
                                        GoogleFonts.fascinate(textStyle: style),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 115,
                  width: MediaQuery.of(context).size.width,
                  child: SizedBox(
                    height: 200,
                    child: BorderedText(
                      strokeWidth: 5.0,
                      strokeColor: Colors.white,
                      child: Text(
                        'You!',
                        style: GoogleFonts.fascinate(textStyle: style2),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ButtonWidget(
                          text: 'Contacts',
                          icon: Icons.person,
                          onClick: () {
                            _showContactList(context);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ButtonWidget(
                            text: 'Message',
                            icon: Icons.mail,
                            onClick: () {
                              _showMessageList(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showContactList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => ContactList()),
      ),
    );
  }

  void _showMessageList(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => MessageList())));
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key, required this.text, required this.icon, required this.onClick})
      : super(key: key);

  final String text;
  final IconData icon;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.black, width: 1)),
      child: InkWell(
        onTap: onClick,
        child: SizedBox(
          height: 90,
          width: 90,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                child: Stack(
                  children: [
                    Icon(
                      icon,
                      size: 40,
                    ),
                  ],
                ),
              ),
              BorderedText(
                strokeWidth: 2.0,
                strokeColor: Colors.black,
                child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
