import 'package:chatapp/Models/Massage_models.dart';
import 'package:chatapp/constant/Colors.dart';
import 'package:chatapp/constant/formet_data.dart';
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
    return widget.isImage
        ? Container(
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
                    Container(
                      margin: EdgeInsets.all(4.r),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        child: Image.network(
                          'https://cuteprofilepictures.weebly.com/uploads/2/1/8/5/21856578/638057_orig.jpg',
                          width: 200.w,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.r),
                          child: Text(
                            formetdata(widget.msg.timestamp!),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ),
                        widget.msg.sender == widget.currentUser
                            ? widget.msg.isSeenByReceiver!
                                ? Icon(
                                    Icons.check_circle_outline,
                                    size: 16,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.check_circle_outline,
                                    size: 16,
                                    color: kprimarycolor,
                                  )
                            : SizedBox()
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        : Container(
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
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.75),
                          decoration: BoxDecoration(
                            color: widget.msg.sender == widget.currentUser
                                ? Colors.green[300]
                                : Colors.grey[300],
                            borderRadius: BorderRadius.only(
                              bottomLeft:
                                  widget.msg.sender == widget.currentUser
                                      ? Radius.circular(2.r)
                                      : Radius.circular(15.r),
                              topRight: widget.msg.sender == widget.currentUser
                                  ? Radius.circular(2.r)
                                  : Radius.circular(15.r),
                              bottomRight:
                                  widget.msg.reciver == widget.currentUser
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
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.r),
                          child: Text(
                            formetdata(widget.msg.timestamp!),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ),
                        widget.msg.sender == widget.currentUser
                            ? widget.msg.isSeenByReceiver!
                                ? Icon(
                                    Icons.check_circle_outline,
                                    size: 16,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.check_circle_outline,
                                    size: 16,
                                    color: kprimarycolor,
                                  )
                            : SizedBox()
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
