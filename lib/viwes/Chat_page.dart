import 'package:chatapp/Models/Massage_models.dart';
import 'package:chatapp/Models/userData.dart';
import 'package:chatapp/constant/Chatmassage.dart';
import 'package:chatapp/constant/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController MessageController = TextEditingController();
  List message = [
    MassageModels(
        message: 'Hello',
        sender: '101',
        reciver: '202',
        timestamp: DateTime(2024, 10, 10),
        isSeenByReceiver: false),
    MassageModels(
        message: 'hi',
        sender: '202',
        reciver: '101',
        timestamp: DateTime(2024, 10, 11),
        isSeenByReceiver: false),
    MassageModels(
        message: 'how are you',
        sender: '101',
        reciver: '202',
        timestamp: DateTime(2024, 10, 12),
        isSeenByReceiver: false),
    MassageModels(
      message: 'i am fine and you',
      sender: '202',
      reciver: '101',
      timestamp: DateTime(2024, 10, 13),
      isSeenByReceiver: false,
      isImage: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    // final arguments = ModalRoute.of(context)!.settings.arguments;
    // if (arguments is Userdata) {
    //   Userdata reciver = arguments;
    // }
    Userdata reciver = ModalRoute.of(context)!.settings.arguments as Userdata;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[400],
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reciver.name!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  reciver.isOnline! == true ? "Online" : "Offline",
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.r),
              child: ListView.builder(
                itemCount: message.length,
                itemBuilder: (context, index) => ChatMessage(
                  msg: message[index],
                  currentUser: '101',
                  isImage: true,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(6.r),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: ksecondarycolor,
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: MessageController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type a message...'),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.image),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
