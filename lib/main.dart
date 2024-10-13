import 'package:chatapp/controller/appwrite_controller.dart';
import 'package:chatapp/viwes/HomePage.dart';
import 'package:chatapp/viwes/Phonelogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 390),
      splitScreenMode: true,
      minTextAdapt: true,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "First Chat",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
            ),
            useMaterial3: false,
          ),
          routes: {
            // "/": (context) => Phonelogin(),
            "/": (context) => ChackUserSession(),
            "Login": (context) => Phonelogin(),
          }),
    );
  }
}

class ChackUserSession extends StatefulWidget {
  @override
  State<ChackUserSession> createState() => _ChackUserSessionState();
}

class _ChackUserSessionState extends State<ChackUserSession> {
  @override
  void initState() {
    super.initState();
    ChackSession().then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Phonelogin()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
