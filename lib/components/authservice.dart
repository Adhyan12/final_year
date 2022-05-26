import 'package:final_year_project/components/constants.dart';
import 'package:final_year_project/components/helperfunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  signOut() {
    FirebaseAuth.instance.signOut();
    Constants.myName='';
    Constants.userType='';
    HelperFunctions.saveUserLoggedInSharedPreference(false);
    HelperFunctions.saveUserNameSharedPreference('');
  }

  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds =
    PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }
}
