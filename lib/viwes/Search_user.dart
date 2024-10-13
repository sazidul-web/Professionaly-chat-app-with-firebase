import 'package:chatapp/constant/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserSearch extends StatefulWidget {
  @override
  State<UserSearch> createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Search user',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.r),
          child: Container(
            decoration: BoxDecoration(
              color: ksecondarycolor,
              borderRadius: BorderRadius.all(
                Radius.circular(6.r),
              ),
            ),
            margin: EdgeInsets.all(8.r),
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 4.r),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter phone number'),
                  ),
                ),
                Icon(Icons.search)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
