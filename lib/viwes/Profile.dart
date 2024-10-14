import 'package:chatapp/controller/appwrite_controller.dart';
import 'package:chatapp/viwes/Phonelogin.dart';
import 'package:chatapp/viwes/Update_profilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
          'Profile',
          style: TextStyle(color: Colors.black, fontSize: 18.sp),
        ),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UpdateProfilePage()));
            },
            child: ListTile(
              leading: CircleAvatar(
                  backgroundImage: Image(
                image: AssetImage(
                  'assets/user.png',
                ),
              ).image),
              title: Text(
                'Current user',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                '+8801999076918',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
              trailing: Icon(Icons.edit_outlined),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              logoutuser();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Phonelogin()));
            },
            leading: Icon(Icons.logout_outlined),
            title: Text('LogOut'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
