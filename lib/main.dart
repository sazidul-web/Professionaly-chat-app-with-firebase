import 'package:chatapp/viwes/HomePage.dart';
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
            "/": (context) => HomePage(),
            "home": (context) => HomePage(),
          }),
    );
  }
}
