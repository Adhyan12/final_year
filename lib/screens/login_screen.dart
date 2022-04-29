import 'package:flutter/material.dart';
import 'package:final_year_project/components/login_form.dart';

class LoginScreen extends StatelessWidget {

  static const String id = 'LoginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
      body:const Padding(
        padding:  EdgeInsets.only(top:50.0, left: 10,right: 10),
        child:  Center(
          child:AuthenticationForm(),
        ),
      ),
    );
  }
}
