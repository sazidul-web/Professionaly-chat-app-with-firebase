import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('670b65b9001728ab8104');

const String db = '670b68ff002b9c8bc853';
const String userCollection = '670b690c000f1a23ea5a';
Account account = Account(client);
final Databases databases = Databases(client);

// Save Phone number to databae (Creating a new account)
Future<bool> Savephonetodb(
    {required String phoneno, required String userID}) async {
  try {
    final Response = await databases.createDocument(
        databaseId: db,
        collectionId: userCollection,
        documentId: userID,
        data: {
          "Phone_no": phoneno,
          "userID": userID,
        });
    print(Response);
    return true;
  } on AppwriteException catch (e) {
    print('Cannot save to user data: ${e}');
    return false;
  }
}

// check whether phone number exist in DB or not
Future<String> ChackPhoneNumber({required String phoneno}) async {
  try {
    final DocumentList matchuser = await databases.listDocuments(
        databaseId: db,
        collectionId: userCollection,
        queries: [Query.equal("Phone_no", phoneno)]);
    if (matchuser.total > 0) {
      final Document user = matchuser.documents[0];
      if (user.data["Phone_no"] != null || user.data["Phone_no"] != "") {
        return user.data["userID"];
      } else {
        print('No user exist on db');
        return 'user not exist';
      }
    } else {
      print('No user exist on db');
      return 'user not exist';
    }
  } on AppwriteException catch (e) {
    print('error on reding database $e');
    return 'user not exist';
  }
}

// create a phone session , send otp to the phone number
Future<String> createPhonesession({required String phone}) async {
  try {
    final userID = await ChackPhoneNumber(phoneno: phone);
    if (userID == "user not exist") {
      // creating new account
      final Token data =
          await account.createPhoneToken(userId: ID.unique(), phone: phone);
      // save the new user to user collaction
      Savephonetodb(phoneno: phone, userID: data.userId);
      return data.userId;
    } else {
      // create phone token for existing user
      final Token data =
          await account.createPhoneToken(userId: userID, phone: phone);
      return data.userId;
    }
  } catch (e) {
    print('error on create phone session: ${e}');
    return 'Login error';
  }
}

// Funtion login with OTP
Future<bool> loginwithOTP({required String otp, required String userId}) async {
  try {
    final Session session =
        await account.updatePhoneSession(userId: userId, secret: otp);
    print(session..userId);
    return true;
  } catch (e) {
    print('error on login with otp: ${e}');
    return false;
  }
}

// to chack whater the session exist or not
Future<bool> ChackSession() async {
  try {
    final Session session = await account.getSession(sessionId: "current");
    print("Session exist${session.$id}");
    return true;
  } catch (e) {
    return false;
  }
}
