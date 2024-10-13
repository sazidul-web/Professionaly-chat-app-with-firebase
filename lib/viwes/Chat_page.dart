import 'package:chatapp/Models/Massage_models.dart';
import 'package:chatapp/constant/Chatmassage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List message = [
    MassageModels(
        message: 'Hello',
        sender: '101',
        reciver: '202',
        timestamp: DateTime(2000),
        isSeenByReceiver: false),
    MassageModels(
        message: 'hi',
        sender: '202',
        reciver: '101',
        timestamp: DateTime(2000),
        isSeenByReceiver: false),
    MassageModels(
        message: 'how are you',
        sender: '101',
        reciver: '202',
        timestamp: DateTime(2000),
        isSeenByReceiver: false),
    MassageModels(
        message: 'i am fine and you',
        sender: '202',
        reciver: '101',
        timestamp: DateTime(2000))
  ];
  @override
  Widget build(BuildContext context) {
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
                  'Other user',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'Online',
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
      body: ListView.builder(
        itemCount: message.length,
        itemBuilder: (context, index) => ChatMessage(
          msg: message[index],
          currentUser: '101',
          isImage: false,
        ),
      ),
    );
  }
}
