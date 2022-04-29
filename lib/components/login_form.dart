import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_year_project/screens/screens.dart';
import 'authservice.dart';
import 'constants.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm({Key? key}) : super(key: key);

  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  String phoneNo = '+91', verificationId = "", smsCode = "", name = "";
  bool codeSent = false;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start
        children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
              icon: const Icon(Icons.phone),
              hintText: 'Enter phone number',
              labelText: 'Phone',
            ),
            validator: (value) {
              //check back for null in the statement down below
              if (value!.isEmpty) {
                return 'Please enter valid phone number';
              }
              return null;
            },
            onChanged: (value) {
              phoneNo = value;
            },
          ),
          codeSent
              ? Center(
              child: Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: kInputBoxDecoration.copyWith(
                          hintText: 'Enter OTP'),
                      onChanged: (val) {
                        smsCode = val;
                      })))
              : Container(),
          const SizedBox(height: 20.0),
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
                ),
                child: Center(
                    child:
                    codeSent ? const Text('Login',style: TextStyle(fontSize: 20),) : const Text('Send OTP',style: TextStyle(fontSize: 20),)),
                onPressed: () async {
                  // if (codeSent == false) phoneNo = '+91' + phoneNo;
                  // print(phoneNo);
                  // codeSent
                  //     ? AuthService().signInWithOTP(smsCode, verificationId)
                  //     : verifyPhone(phoneNo);
                  // if (codeSent == false) {
                  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //     content: Text('OTP has been sent'),
                  //   ));

                  // } else {
                  //check for null in uid in the statement below
                  // await _firestore
                  //     .collection('users')
                  //     .doc(FirebaseAuth.instance.currentUser!.uid)
                  //     .set({"name": name, "phonenumber": phoneNo});
                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(
                  //         builder: (context) => UserDashBoard()));
                  // }
                  Navigator.pushNamed(context, UserDashBoard.id);
                }),
          ),
        ],
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };
//check for nullable function foreReSend
    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeSent smsSent = (String verId, [int? forceResend]) {
      verificationId = verId;
      setState(() {
        codeSent = true;
      });
    };
    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
