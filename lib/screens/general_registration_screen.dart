import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'screens.dart';
import 'package:connectivity/connectivity.dart';

class GeneralRegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';

  const GeneralRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<GeneralRegistrationScreen> createState() =>
      _GeneralRegistrationScreenState();
}

class _GeneralRegistrationScreenState extends State<GeneralRegistrationScreen> {
  void toast() {
    Fluttertoast.showToast(
        msg: 'No Internet connectivity',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16);
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
    } else {
      toast();
    }
  }

  @override
  void initState() {

    checkConnectivity();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background-1.jpeg'),
                fit: BoxFit.fitHeight),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                        image:
                        DecorationImage(image: AssetImage('images/logo.png'))),
                  ),
                  const Text(
                    'Register As',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already a User?',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: const Text('Login',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline)))
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, PharmaRegistration.id);
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/pharmacy.png'),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, UserRegistration.id);
                        },
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
                      // const SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, VetRegistrationScreen.id);
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/veterinarian.png'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(height: MediaQuery.of(context).size.height*0.27),
                ],
              ),
              const Center(
                child: Text(
                  'Crafted with ❤',
                  style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa', fontWeight: FontWeight.w200),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
