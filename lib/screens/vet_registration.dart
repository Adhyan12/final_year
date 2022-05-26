import 'package:final_year_project/screens/vet_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/authservice.dart';
import '../components/database.dart';
import '../components/helperfunctions.dart';

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
      body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: VetRegistrationForm(),
            ),
          )),
    );
  }
}
// Form(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//
//             children: [
//               Center(
//                 child: Container(
//                   height: 100,
//                   width: 100,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('images/veterinarian.png'),
//                     ),
//                   ),
//                 ),
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   icon: const Icon(Icons.person),
//                   hintText: 'Enter your name',
//                   labelText: 'Name',
//                 ),
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0)),
//                   icon: const Icon(Icons.perm_contact_calendar_rounded),
//                   hintText: "What's your age",
//                   labelText: 'Age',
//                 ),
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30.0)),
//                   icon: const Icon(Icons.pending_actions_rounded),
//                   hintText: 'Tell us about yourself',
//                   labelText: 'Description',
//                 ),
//               ),
//             ],
//           ),
//         ),

// ignore: must_be_immutable
class VetRegistrationForm extends StatefulWidget {
  const VetRegistrationForm({
    Key? key,
  }) : super(key: key);

  @override
  State<VetRegistrationForm> createState() => _VetRegistrationFormState();
}

class _VetRegistrationFormState extends State<VetRegistrationForm> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var numController = TextEditingController();
  var descriptionController = TextEditingController();

  bool codeSent = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  String name = '',
      age = '',
      phoneNo = '',
      descript = '',
      verificationId = '',
      smsCode = '';

  Database database = Database();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            Center(
                child: Image.asset(
              'images/veterinarian.png',
              fit: BoxFit.contain,
              height: 100,
            )),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                icon: const Icon(Icons.person),
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
              validator: (name) {
                if (name == null) return 'Enter a valid name';
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                icon: const Icon(Icons.perm_contact_calendar_rounded),
                hintText: 'Enter your age',
                labelText: 'Age',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                icon: const Icon(Icons.pending_actions_rounded),
                hintText: 'Tell us about yourself',
                labelText: 'Description',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: numController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                icon: const FaIcon(FontAwesomeIcons.phone),
                hintText: 'Enter your mobile number',
                labelText: 'Mobile Number',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
                onPressed: () async {
                  name = nameController.text;
                  age = ageController.text;
                  phoneNo = '+91' + numController.text;
                  descript = descriptionController.text;
                  //TODO: check for existing user
                  Map<String, String> vetMap = {
                    'UserName': name,
                    'Age': age,
                    'PhoneNo': phoneNo,
                    'descript': descript
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
                    await database.createDocument(vetMap, 'vet');
                    await HelperFunctions.saveUserLoggedInSharedPreference(
                        true);
                    await HelperFunctions.saveUserNameSharedPreference(name);
                    await HelperFunctions.saveUserTypeSharedPreference('vet');
                    Navigator.pushReplacementNamed(context, VetDashBoard.id);
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
