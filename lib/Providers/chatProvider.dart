import 'package:chatapp/Models/ChatDataModel.dart';
import 'package:chatapp/Models/Massage_models.dart';
import 'package:chatapp/Models/userData.dart';
import 'package:chatapp/controller/appwrite_controller.dart';
import 'package:flutter/foundation.dart';

class ChatProvider extends ChangeNotifier {
  Map<String, List<ChatDataModel>> chat = {};

  // Get all users' chats
  Map<String, List<ChatDataModel>> get getAllChats => chat;

  // Load all current user chats
  void loadChat(String currentUser) async {
    Map<String, List<ChatDataModel>>? loadedChat =
        await currentuserChats(currentUser);

    if (loadedChat != null) {
      chat = loadedChat;
      chat.forEach((key, value) {
        // Sorting messages by timestamp in ascending order
        value.sort(
            (a, b) => a.message.timestamp!.compareTo(b.message.timestamp!));
      });
      print('Chat uploaded in provider');
      notifyListeners();
    }
  }

  void addmessage(
      MassageModels message, String currentUser, List<Userdata> users) {
    try {
      if (message.sender == currentUser) {
        if (chat[message.reciver] == null) {
          chat[message.reciver!] = [];
        }
        chat[message.reciver]!
            .add(ChatDataModel(message: message, users: users));
      } else {
        if (chat[message.sender] == null) {
          chat[message.sender!] = [];
        }
        chat[message.sender]!
            .add(ChatDataModel(message: message, users: users));
      }
      notifyListeners();
    } catch (e) {
      print("error in chat provider on message adding");
    }
  }

  void deleteMessage(
      MassageModels message, String currentUser, String? imageID) async {
    try {
      // user deleted this message
      if (message.sender == currentUser) {
        chat[message.reciver]!
            .removeWhere((element) => element.message == message);
        if (imageID != null) {
          deleteimagefrombucket(oldImageId: imageID);
          print("images deletes from bucket");
        }
        deletecurrentuserchat(chatId: message.message!);
      } else {
        // current user in reciver
        chat[message.sender]!
            .removeWhere((element) => element.message == message);
        print("message deleted");
      }
      notifyListeners();
    } catch (e) {
      print("erorr on message deleted chat message $e");
    }
  }
}
