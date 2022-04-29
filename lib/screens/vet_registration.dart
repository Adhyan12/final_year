import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VetRegistrationScreen extends StatefulWidget {
  const VetRegistrationScreen({Key? key}) : super(key: key);
  static const String id = 'VetRegistrationScreen';

  @override
  State<VetRegistrationScreen> createState() => _VetRegistrationScreenState();
}

class _VetRegistrationScreenState extends State<VetRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_sharp,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'images/logo.png',
              fit: BoxFit.contain,
              height: 35,
            )
          ],
        ),
      ),
      body: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Center(
                child: Image.asset(
              'images/doc.jpeg',
              fit: BoxFit.contain,
              height: 100,
            )),
          ),
          TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              icon: const Icon(Icons.person),
              hintText: 'Enter your name',
              labelText: 'Name',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              icon: const Icon(Icons.perm_contact_calendar_rounded),
              hintText: "What's your age",
              labelText: 'Age',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              icon: const Icon(Icons.pending_actions_rounded),
              hintText: 'Tell us about yourself',
              labelText: 'Description',
            ),
          ),
        ],
      )),
    );
  }
}
