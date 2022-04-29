import 'package:flutter/material.dart';
import 'package:final_year_project/components/user_registrationform.dart';

class UserRegistration extends StatelessWidget {
  const UserRegistration({Key? key}) : super(key: key);
  static const String id = 'UserRegistration';

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
      body: const UserRegistrationForm(),
    );
  }
}
