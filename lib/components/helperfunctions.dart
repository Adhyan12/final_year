import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserNumberKey = "USERNUMBER";
  static String sharedPreferenceUserTypeKey = 'USERTYPE';


  //saving data to sharedPreference
  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn)async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String userName)async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserNumberSharedPreference(String number)async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNumberKey, number);
  }

  static Future<bool> saveUserTypeSharedPreference(String type)async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserTypeKey, type);
  }
  //getting data from sharedPreference

  static Future<bool?> getUserLoggedInSharedPreference()async {
    final prefs = await SharedPreferences.getInstance();
    return  prefs.getBool(sharedPreferenceUserLoggedInKey);
  }
  static Future<String?> getUserNameSharedPreference()async {
    final prefs = await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceUserNameKey);
  }
  static Future<String?> getUserNumberSharedPreference()async {
    final prefs = await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceUserNumberKey);
  }

  static Future<String?> getUserTypeSharedPreference()async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserTypeKey);
  }

}