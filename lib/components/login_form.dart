import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/components/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_year_project/screens/screens.dart';
import 'authservice.dart';
import 'constants.dart';
import 'database.dart';
import 'package:final_year_project/screens/pharma_dashboard.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm({Key? key}) : super(key: key);

  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  String  verificationId = "", smsCode = "", name = "",data='';
  bool codeSent = false;
  final _firestore = FirebaseFirestore.instance;

  TextEditingController phoneNoController = TextEditingController();

  Database database = Database();
  late QuerySnapshot snapshotUserInfo;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneNoController,
              decoration: InputDecoration(
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
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
            ),
          ),
          const SizedBox(height: 20,),
          codeSent
             ?  Center(
              child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: kInputBoxDecoration.copyWith(
                          hintText: 'Enter OTP'),
                      onChanged: (val) {
                        smsCode = val;
                      },),),)
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
                  data = database.searchDocument('+91'+phoneNoController.text.toString());
                  if(data==''){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Not Registered'),
                      ),
                    );
                  }
                  else{
                    codeSent
                        ? AuthService().signInWithOTP(smsCode, verificationId)
                        : verifyPhone('+91'+phoneNoController.text.toString());
                    if (codeSent == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('OTP has been sent'),
                        ),
                      );

                      //TODO: check for username and pass it to respective screen
                    }else{
                      // snapshotUserInfo= database.getDocumentsByPhoneNumber('+91'+phoneNoController.text, data);
                      // HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo.docs[0]['name']);
                      if(data=='user') {
                        Navigator.pushReplacementNamed(context, UserDashBoard.id);
                      } else if(data=='vet') {
                        Navigator.pushReplacementNamed(context, VetDashBoard.id);
                      } else {
                        Navigator.pushReplacementNamed(context, PharmaDashBoard.id);
                      }
                    }
                  }
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
