import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:final_year_project/screens/screens.dart';

class PharmaRegistration extends StatefulWidget {
  const PharmaRegistration({Key? key}) : super(key: key);
  static const String id = 'PharmaRegistration';

  @override
  State<PharmaRegistration> createState() => _PharmaRegistrationState();
}

class _PharmaRegistrationState extends State<PharmaRegistration> {
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
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: PharmaRegistrationForm(),
          ),
        ),
      ),
    );
  }
}

class PharmaRegistrationForm extends StatelessWidget {
  const PharmaRegistrationForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
              child: Image.asset(
            'images/drugstore.png',
            fit: BoxFit.contain,
            height: 100,
          )),
          TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              icon: const Icon(Icons.home),
              hintText: 'Enter your shop name',
              labelText: 'Name',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              icon: const FaIcon(FontAwesomeIcons.locationDot),
              hintText: 'Enter your shop address',
              labelText: 'Address',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
              icon: const FaIcon(FontAwesomeIcons.phone),
              hintText: 'Enter your mobile number',
              labelText: 'Mobile Number',
            ),
          ),
          Row(
            children: [
              Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.blue),
                      image: const DecorationImage(
                          image: AssetImage(
                        'images/building-placeholder.png',
                      )))),
              const SizedBox(width: 5),
              TextButton(
                child: Row(children: const [
                  Text(
                    'Upload Photo',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.upload_sharp,
                    size: 30,
                  )
                ]),
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: const BorderSide(color: Colors.blue),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(10.0)),
              child: const Center(
                  child: Text('Submit', style: TextStyle(fontSize: 20))),
              onPressed: () {
                Navigator.pushNamed(context, PharmaDashBoard.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
