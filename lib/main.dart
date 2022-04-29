import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/screens.dart';
import 'components/camera.dart';
import 'package:camera/camera.dart';

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

class Pawws extends StatelessWidget {
  const Pawws({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GeneralRegistrationScreen(),
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
      },
    );
  }
}
