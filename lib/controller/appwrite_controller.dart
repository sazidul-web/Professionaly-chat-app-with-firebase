import 'dart:async';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:chatapp/Models/userData.dart';
import 'package:chatapp/Providers/user_data_provider.dart';
import 'package:chatapp/main.dart';
import 'package:provider/provider.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('670b65b9001728ab8104');

const String db = '670b68ff002b9c8bc853';
const String userCollection = '670b690c000f1a23ea5a';
const String StoregBucket = '670ce544003d21242221';
Account account = Account(client);
final Storage storage = Storage(client);
final Databases databases = Databases(client);
// for otp need
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

// for otp need
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

// for otp need
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

// for otp need
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

// for otp need
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

// to logout the use and and delete session
Future logoutuser() async {
  await account.deleteSession(sessionId: "current");
}

// load userData ->>>>>>>>>>>>>>>>>>>>>userData
Future<Userdata?> getUserDetails({required String userId}) async {
  try {
    final response = await databases.getDocument(
        databaseId: db, collectionId: userCollection, documentId: userId);
    print("Getting userdata");
    print("${response.data}");
    return Userdata.toMap(response.data);
  } catch (e) {
    print("Error in getting userdata ${e}");
    return null;
  }
}

// to update the user data
Future<bool> updateDatauserdetails(String pic,
    {required String userId, required String name}) async {
  try {
    final data = await databases.updateDocument(
        databaseId: db,
        collectionId: userCollection,
        documentId: userId,
        data: {"name": name, "Profile_pic": pic});
    Provider.of<UserDataProvider>(navigatorkey.currentContext!, listen: false)
        .setUserName(name);
    Provider.of<UserDataProvider>(navigatorkey.currentContext!, listen: false)
        .setUserProfile(pic);
    print(data);
    return true;
  } on AppwriteException catch (e) {
    print("Cannot save to db $e");
    return false;
  }
}

// upload and save images to storeg bucket (Create new image)
Future<String?> saveImageToBucket({required InputFile image}) async {
  try {
    final responce = await storage.createFile(
        bucketId: StoregBucket, fileId: ID.unique(), file: image);
    print("The responce after save the bucket $responce");
    return responce.$id;
  } catch (e) {
    print("Error on saving image to bucket :$e");
    return null;
  }
}

// update an image in bucket first delete then create new
Future<String?> UpdateImageOnBacket(
    {required String oldImageId, required InputFile image}) async {
  try {
    // to delete the old image
    deleteimagefrombucket(oldImageId: oldImageId);
    // create new image id
    final newImage = saveImageToBucket(image: image);
    return newImage;
  } catch (e) {
    print("Cannot update & delete image: $e");
    return null;
  }
}

// to only delete the image from storeg bucket
Future<bool> deleteimagefrombucket({required String oldImageId}) async {
  try {
    await storage.deleteFile(bucketId: StoregBucket, fileId: oldImageId);
    return true;
  } catch (e) {
    print("Cannot update & delete image: $e");
    return false;
  }
}
