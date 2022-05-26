import 'package:final_year_project/components/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:final_year_project/components/camera.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:final_year_project/screens/screens.dart';
import 'package:final_year_project/components/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/components/database.dart';

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
      lname = '',
      pname = '',
      location = '',
      breed = '';
  bool codeSent = false;
  String age = '5';
  final _firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Database database = Database();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/dog-training.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
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
                const SizedBox(
                  height: 20,
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
                        onChanged: (value) {
                          location = value;
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
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
                        onChanged: (value) {
                          pname = value;
                        },
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
                            keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          icon: const Icon(Icons.pets_rounded),
                          hintText: "Your pet's age",
                          labelText: 'Age',
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: () {
                          Navigator.pushNamed(context, Cameras.id);
                        },
                      ),
                      hintText: 'Breed',
                      labelText: 'Breed',
                    ),
                    onChanged: (value) {
                      breed = value;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Gender',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
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
                        trailing:
                            const Text('Male', style: TextStyle(fontSize: 25)),
                      ),
                    ),
                    Expanded(
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
                        trailing: const Text(
                          'Female',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ],
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
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      name = fname + ' ' + lname;
                      if (phoneNo != '') {
                        if (phoneNo.startsWith('+91') == false) {
                          phoneNo = '+91' + phoneNo;
                        }
                        print(phoneNo);
                        print(name);
                        codeSent
                            ? AuthService()
                                .signInWithOTP(smsCode, verificationId)
                            : verifyPhone(phoneNo);
                        if (codeSent == false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('OTP has been sent'),
                            ),
                          );
                        } else {
                          Map<String, String> UserMap = {
                            'UserName': name,
                            'PhoneNo': phoneNo,
                            'Location': location,
                            'petName': pname,
                            'petAge': age,
                            'breed': breed
                          };
                          await database.createDocument(UserMap, 'user');
                          HelperFunctions.saveUserLoggedInSharedPreference(
                              true);
                          HelperFunctions.saveUserNameSharedPreference(name);
                          HelperFunctions.saveUserTypeSharedPreference('user');
                          // print(HelperFunctions.ge)
                          Navigator.pushReplacementNamed(
                              context, UserDashBoard.id);
                        }
                      }
                    },
                  ),
                ),
              ]),
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
