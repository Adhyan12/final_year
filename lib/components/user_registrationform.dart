import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:final_year_project/components/camera.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:final_year_project/screens/screens.dart';
import 'package:final_year_project/components/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/screens/screens.dart';

class UserRegistrationForm extends StatefulWidget {
  const UserRegistrationForm({Key? key}) : super(key: key);

  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

enum Gender { male, female }

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  Gender? _gender = Gender.male;
  String phoneNo = '',
      verificationId = '',
      smsCode = '',
      name = '',
      fname = '',
      lname = '';
  bool codeSent = false;
  var age = 5;
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Center(
              child: Text(
                'Welcome hooman',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        icon: const Icon(Icons.person),
                        hintText: 'Enter your first name',
                        labelText: 'First Name',
                      ),
                      onChanged: (value) {
                        fname = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Please enter your name';
                        else
                          return null;
                      }),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      hintText: 'Enter your last name',
                      labelText: 'Last Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'Please enter last name';
                      else
                        return null;
                    },
                    onChanged: (value) {
                      lname = value;
                    },
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      icon: const Icon(Icons.phone),
                      hintText: '+91',
                      labelText: 'Mobile Number',
                    ),
                    onChanged: (value) {
                      phoneNo = value;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      icon: const FaIcon(FontAwesomeIcons.locationDot),
                      hintText: 'Your location',
                      labelText: 'Location',
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      icon: const Icon(Icons.pets_sharp),
                      hintText: 'Enter your pet name',
                      labelText: 'Pet Name',
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child:
                      // showMaterialNumberPicker(
                      //   context: context,
                      //   title: "Pet's Age",
                      //   maxNumber: 20,
                      //   minNumber: 0,
                      //   selectedNumber: age,
                      //   onChanged: (value) => setState(() => age = value),
                      // ),
                      TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      icon: const Icon(Icons.pets_rounded),
                      hintText: "Your pet's age",
                      labelText: 'Age',
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: () {
                          // Navigator.pushNamed(context, Cameras.id);
                        },
                      ),
                      hintText: 'Breed',
                      labelText: 'Breed',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Gender', style: TextStyle(fontSize: 20)),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    leading: Radio(
                      value: Gender.male,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    leading: Radio(
                      value: Gender.female,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            codeSent
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            hintText: 'Enter OTP',
                            labelText: 'OTP',
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
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
                onPressed: () {
                  // name = fname + ' ' + lname;
                  // if (codeSent == false && phoneNo.startsWith('+91') == false)
                  //   phoneNo = '+91' + phoneNo;
                  // print(phoneNo);
                  // print(name);
                  // codeSent
                  //     ? AuthService().signInWithOTP(smsCode, verificationId)
                  //     : verifyPhone(phoneNo);
                  // if (codeSent == false) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: Text('OTP has been sent'),
                  //     ),
                  //   );
                  // } else {
                  //   await _firestore
                  //       .collection("users")
                  //       .doc(FirebaseAuth.instance.currentUser!.uid)
                  //       .set({"name": name, "phonenumber": phoneNo});
                  //   Navigator.pushReplacementNamed(context, UserDashBoard.id);
                  // }
                  Navigator.pushNamed(context, UserDashBoard.id);
                },
              ),
            ),
          ]),
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
