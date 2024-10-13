import 'package:chatapp/Models/Massage_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatMessage extends StatefulWidget {
  final MassageModels msg;
  final String currentUser;
  final bool isImage;

  const ChatMessage({
    Key? key,
    required this.msg,
    required this.currentUser,
    required this.isImage,
  }) : super(key: key);

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.r),
      child: Row(
        mainAxisAlignment: widget.msg.sender == widget.currentUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: widget.msg.sender == widget.currentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: widget.msg.sender == widget.currentUser
                          ? Colors.green[300]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        bottomLeft: widget.msg.sender == widget.currentUser
                            ? Radius.circular(2.r)
                            : Radius.circular(15.r),
                        topRight: widget.msg.sender == widget.currentUser
                            ? Radius.circular(2.r)
                            : Radius.circular(15.r),
                        bottomRight: widget.msg.reciver == widget.currentUser
                            ? Radius.circular(2.r)
                            : Radius.circular(15.r),
                        topLeft: widget.msg.reciver == widget.currentUser
                            ? Radius.circular(2.r)
                            : Radius.circular(15.r),
                      ),
                    ),
                    child: Text(
                      widget.msg.message!,
                      style: TextStyle(
                          color: widget.msg.sender == widget.currentUser
                              ? Colors.white
                              : Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Row(
                children: [],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
