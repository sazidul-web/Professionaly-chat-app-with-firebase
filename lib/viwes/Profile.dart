import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/Providers/user_data_provider.dart';
import 'package:chatapp/controller/appwrite_controller.dart';
import 'package:chatapp/viwes/Phonelogin.dart';
import 'package:chatapp/viwes/Update_profilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(builder: (context, value, child) {
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
                Navigator.pushNamed(context, '/update',
                    arguments: {"title": "edit"});
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: value.getuserProfile != null ||
                          value.getuserProfile != ""
                      ? CachedNetworkImageProvider(
                          "https://cloud.appwrite.io/v1/storage/buckets/670ce544003d21242221/files/${value.getuserProfile}/view?project=670b65b9001728ab8104&project=670b65b9001728ab8104&mode=admin")
                      : Image(
                          image: AssetImage(
                            'assets/user.png',
                          ),
                        ).image,
                ),
                title: Text(
                  value.getuserName,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  value.getUserPhone,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
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
    });
  }
}
