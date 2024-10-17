import 'package:chatapp/Models/Massage_models.dart';
import 'package:chatapp/Models/userData.dart';

// class ChatDataModel {
//   final MassageModels massage;
//   final List<Userdata> user;

//   ChatDataModel({required this.massage, required this.user});
// }

class ChatDataModel {
  final MassageModels message;
  final List<Userdata> users;

  ChatDataModel({required this.message, required this.users});
}
