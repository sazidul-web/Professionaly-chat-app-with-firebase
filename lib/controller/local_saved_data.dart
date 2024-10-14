import 'package:shared_preferences/shared_preferences.dart';

class LocalSavedData {
  static SharedPreferences? preferences;
  // initilalization
  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

// save the user id
  static Future<void> SaveUserId(String id) async {
    await preferences!.setString("userId", id);
  }

  // read the user id
  static String GetUserId() {
    return preferences!.getString("userId") ?? "";
  }

  // save the user name
  static Future<void> SaveUserName(String name) async {
    await preferences!.setString("name", name);
  }

  // read the user name
  static String getUserName() {
    return preferences!.getString("name") ?? "";
  }

  // save the user phone
  static Future<void> SaveUserPhone(String phone) async {
    await preferences!.setString("phone", phone);
  }

  // read the user phone
  static String getUserPhone() {
    return preferences!.getString("phone") ?? "";
  }

  // save the user Profile picture
  static Future<void> SaveUserProfile(String profile) async {
    await preferences!.setString("profile", profile);
  }

  // read the user Profile picture
  static String getUserProfile() {
    return preferences!.getString("profile") ?? "";
  }

  // clear all the save data
  static clearalldata() {
    preferences!.clear();
    print('Clear all data from local');
  }
}
