import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/Providers/user_data_provider.dart';
import 'package:chatapp/constant/Colors.dart';
import 'package:chatapp/viwes/Chat_page.dart';
import 'package:chatapp/viwes/Profile.dart';
import 'package:chatapp/viwes/Search_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 3,
        backgroundColor: kprimarycolor,
        title: Text(
          'Chat',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
        actions: [
          GestureDetector(onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          }, child: Consumer<UserDataProvider>(
            builder: (context, value, child) {
              return CircleAvatar(
                  backgroundImage: value.getuserProfile != null ||
                          value.getuserProfile != ""
                      ? CachedNetworkImageProvider(
                          "https://cloud.appwrite.io/v1/storage/buckets/670ce544003d21242221/files/${value.getuserProfile}/view?project=670b65b9001728ab8104&project=670b65b9001728ab8104&mode=admin")
                      : Image(
                          image: AssetImage('assets/user.png'),
                        ).image);
            },
          )),
        ],
      ),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatPage()));
          },
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundImage: Image(
                  image: AssetImage('assets/user.png'),
                ).image,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          title: Text('Other user'),
          subtitle: Text('Hi how are you ?'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: kprimarycolor,
                radius: 10,
                child: Text(
                  '10',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text('20:50'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserSearch()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25.sp,
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
