import 'package:final_year_project/components/helperfunctions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'components/constants.dart';
import 'screens/screens.dart';
import 'components/camera.dart';
import 'package:camera/camera.dart';
import 'package:final_year_project/screens/pharma_dashboard.dart';

var firstCamera;


void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final cameras = await availableCameras();
    firstCamera = cameras.first;
  } catch (e) {
    print(e);
  }
  runApp(const Pawws());
}

class Pawws extends StatefulWidget {
  const Pawws({Key? key}) : super(key: key);

  @override
  State<Pawws> createState() => _PawwsState();
}

class _PawwsState extends State<Pawws> {
  bool userIsLoggedIn = false;
  // bool isLoading = true;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    Constants.userType = (await HelperFunctions.getUserTypeSharedPreference())!;
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value as bool;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userIsLoggedIn
          ? Constants.userType == 'user'
              ? const UserDashBoard()
              : Constants.userType == 'vet'
                  ? const VetDashBoard()
                  : const PharmaDashBoard()
          : const GeneralRegistrationScreen(),
      routes: {
        UserDashBoard.id: (context) => const UserDashBoard(),
        // SplashScreen.id: (context)=> SplashScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        GeneralRegistrationScreen.id: (context) =>
            const GeneralRegistrationScreen(),
        UserRegistration.id: (context) => const UserRegistration(),
        Cameras.id: (context) => Cameras(camera: firstCamera),
        PharmaRegistration.id: (context) => const PharmaRegistration(),
        VetRegistrationScreen.id: (context) => const VetRegistrationScreen(),
        VetDashBoard.id: (context) => const VetDashBoard(),
        PharmaDashBoard.id: (context) => const PharmaDashBoard(),
        PharmSearchScreen.id: (context) => const PharmSearchScreen(),
        VetSearchScreen.id: (context) => const VetSearchScreen(),
        OwnerSearchScreen.id: (context) => const OwnerSearchScreen(),
        // ConversationScreen.id: (context)=> ConversationScreen(),
      },
    );
  }
}
