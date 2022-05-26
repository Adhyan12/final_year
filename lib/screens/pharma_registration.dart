import 'package:final_year_project/components/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_year_project/components/authservice.dart';
import 'package:final_year_project/components/database.dart';
import 'package:final_year_project/screens/pharma_dashboard.dart';

class PharmaRegistration extends StatelessWidget {
  const PharmaRegistration({Key? key}) : super(key: key);
  static const String id = 'PharmaRegistration';

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

// ignore: must_be_immutable
class PharmaRegistrationForm extends StatefulWidget {
  const PharmaRegistrationForm({
    Key? key,
  }) : super(key: key);

  @override
  State<PharmaRegistrationForm> createState() => _PharmaRegistrationFormState();
}

class _PharmaRegistrationFormState extends State<PharmaRegistrationForm> {
  var nameController = TextEditingController();
  var addController = TextEditingController();
  var numController = TextEditingController();

  bool codeSent = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  String shopName = '',
      shopAdd = '',
      phoneNo = '',
      verificationId = '',
      smsCode = '';

  Database database = Database();
  //
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //
  // void validateAndSave() {
  //   final FormState? form = _formKey.currentState;
  //   if (form.validate()) {
  //     print('Form is valid');
  //   } else {
  //     print('Form is invalid');
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            Center(
                child: Image.asset(
              'images/drugstore.png',
              fit: BoxFit.contain,
              height: 100,
            )),
            const SizedBox(height: 20,),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                icon: const Icon(Icons.home),
                hintText: 'Enter your shop name',
                labelText: 'Name',
              ),
              validator: (name){
                if(name==null)return 'Enter a valid name';
              },
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: addController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                icon: const FaIcon(FontAwesomeIcons.locationDot),
                hintText: 'Enter your shop address',
                labelText: 'Address',
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: numController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                icon: const FaIcon(FontAwesomeIcons.phone),
                hintText: 'Enter your mobile number',
                labelText: 'Mobile Number',
              ),
            ),
            const SizedBox(height: 20,),
            // Padding(
            //   padding: const EdgeInsets.only(left:20.0),
            //   child: Row(
            //     children: [
            //       Container(
            //           height: 140,
            //           width: 140,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(30),
            //               border: Border.all(color: Colors.blue),
            //               image: const DecorationImage(
            //                   image: AssetImage(
            //                 'images/building-placeholder.png',
            //               )))),
            //       const SizedBox(width: 5),
            //       TextButton(
            //         child: Row(children: const [
            //           Text(
            //             'Upload Photo',
            //             style: TextStyle(fontSize: 20),
            //           ),
            //           SizedBox(width: 5),
            //           Icon(
            //             Icons.upload_sharp,
            //             size: 30,
            //           )
            //         ]),
            //         onPressed: () {},
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 20,),
            codeSent
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            hintText: 'Enter OTP',
                            labelText: 'OTP',
                          ),
                          onChanged: (value) {
                            smsCode = value;
                          },
                        ),
                      ),
                    ],
                  )
                : Container(),
            // const SizedBox(height: 20,),
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
                child: Center(
                  child: codeSent
                      ? const Text(
                          'Verify',
                          style: TextStyle(fontSize: 20),
                        )
                      : const Text(
                          'Submit',
                          style: TextStyle(fontSize: 20),
                        ),
                ),
                onPressed: () async{
                  shopName = nameController.text.toString();
                  shopAdd = addController.text.toString();
                  phoneNo = '+91' + numController.text.toString();
                  //TODO: check for existing user
                  Map<String, String>pharmaMap = {
                    'UserName': shopName,
                    'Location': shopAdd,
                    'PhoneNo': phoneNo
                  };
                  codeSent
                      ? AuthService().signInWithOTP(smsCode, verificationId)
                      : verifyPhone(phoneNo);
                  if (codeSent == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('OTP has been sent'),
                      ),
                    );
                  } else {
                    await database.createDocument(pharmaMap,'pharmacy');
                    await HelperFunctions.saveUserLoggedInSharedPreference(true);
                    await HelperFunctions.saveUserNameSharedPreference(shopName);
                    await HelperFunctions.saveUserTypeSharedPreference('pharmacy');
                    Navigator.pushReplacementNamed(context, PharmaDashBoard.id);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationCompleted verified =
        (AuthCredential credential) async {
      await AuthService().signIn(credential);
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid');
      }
    };
    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeSent smsSent = (String verId, int? resendToken) async {
      verificationId = verId;
      setState(() {
        codeSent = true;
      });
    };
    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      verificationId = verId;
    };

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verified,
      verificationFailed: verificationFailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }
}
