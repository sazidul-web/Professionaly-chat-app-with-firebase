import 'package:chatapp/Models/userData.dart';
import 'package:chatapp/controller/appwrite_controller.dart';
import 'package:chatapp/controller/local_saved_data.dart';
import 'package:flutter/foundation.dart';

class UserDataProvider extends ChangeNotifier {
  String _userId = "";
  String _userName = "";
  String _userProfilepic = "";
  String _userPhoneNumber = "";
  String _userDeviceToken = "";

  String get getuserId => _userId;
  String get getuserName => _userName;
  String get getuserProfile => _userProfilepic;
  String get getUserPhone => _userPhoneNumber;
  String get getuserDeviceToken => _userDeviceToken;

  // to lead the data form the device
  void loadDatafromLocal() {
    _userId = LocalSavedData.GetUserId();
    _userName = LocalSavedData.getUserName();
    _userProfilepic = LocalSavedData.getUserProfile();
    _userPhoneNumber = LocalSavedData.getUserPhone();
    print("data load form local $_userId,$_userPhoneNumber,$_userName");
    // notifyListeners();
  }

  // to lead the data form our appwrite database user collection ----->>>>>>>>>>>>>>>>> appwrite controller and userData funtion.
  void loadUserData(String userId) async {
    Userdata? userdata = await getUserDetails(userId: userId);
    if (userdata != null) {
      _userName = userdata.name ?? "";
      _userProfilepic = userdata.profilepic ?? "";
      notifyListeners();
    }
  }

  // setUserid
  void setUserId(String id) {
    _userId = id;
    LocalSavedData.SaveUserId(id);
    notifyListeners();
  }

  // setUserName
  void setUserName(String name) {
    _userName = name;
    LocalSavedData.SaveUserName(name);
    notifyListeners();
  }

  // serUserphone
  void setUserPhone(String phone) {
    _userPhoneNumber = phone;
    LocalSavedData.SaveUserPhone(phone);
    notifyListeners();
  }

  // setUserProfile
  void setUserProfile(String profile) {
    _userProfilepic = profile;
    LocalSavedData.SaveUserProfile(profile);
    notifyListeners();
  }

  // setDeviceToken
  void setDeviceToken(String token) {
    _userDeviceToken = token;
    notifyListeners();
  }
}
