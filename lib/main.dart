import 'package:chatapp/Providers/user_data_provider.dart';
import 'package:chatapp/controller/appwrite_controller.dart';
import 'package:chatapp/controller/local_saved_data.dart';
import 'package:chatapp/viwes/Chat_page.dart';
import 'package:chatapp/viwes/HomePage.dart';
import 'package:chatapp/viwes/Phonelogin.dart';
import 'package:chatapp/viwes/Update_profilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

final navigatorkey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalSavedData.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 390),
      splitScreenMode: true,
      minTextAdapt: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserDataProvider())
        ],
        child: MaterialApp(
            navigatorKey: navigatorkey,
            debugShowCheckedModeBanner: false,
            title: "First Chat",
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
              ),
              useMaterial3: false,
            ),
            routes: {
              "/": (context) => ChackUserSession(),
              "/update": (context) => UpdateProfilePage(),
              "/chat": (context) => ChatPage(),
            }),
      ),
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
    Future.delayed(Duration.zero, () {
      Provider.of<UserDataProvider>(context, listen: false).loadDatafromLocal();
    });

    ChackSession().then((value) {
      final username =
          Provider.of<UserDataProvider>(context, listen: false).getuserName;
      print('username:${username}');
      if (value) {
        if (username != null && username != "") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, "/update", (route) => false,
              arguments: {"title": "add"});
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Phonelogin()));
      }
    });
    super.initState();
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
