import 'package:chatapp/constant/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
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
            )),
        title: Text(
          "Update",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40.h,
          ),
          Stack(
            children: [
              CircleAvatar(
                  radius: 120,
                  backgroundImage: Image(
                    image: AssetImage('assets/user.png'),
                  ).image),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Icon(
                    Icons.edit_rounded,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            decoration: BoxDecoration(
              color: ksecondarycolor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            margin: EdgeInsets.all(6.r),
            padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
            child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter your name'),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: ksecondarycolor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            margin: EdgeInsets.all(6.r),
            padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
            child: Expanded(
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Phone number'),
              ),
            ),
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r))),
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: SizedBox(
                height: 25.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Update'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kprimarycolor,
                      foregroundColor: ksecondarycolor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
