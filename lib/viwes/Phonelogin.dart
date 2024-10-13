import 'package:chatapp/constant/Colors.dart';
import 'package:chatapp/controller/appwrite_controller.dart';
import 'package:chatapp/viwes/HomePage.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Phonelogin extends StatefulWidget {
  @override
  State<Phonelogin> createState() => _PhoneloginState();
}

class _PhoneloginState extends State<Phonelogin> {
  final _formkey = GlobalKey<FormState>();
  final _formkey1 = GlobalKey<FormState>();
  TextEditingController PhoneNumberVarificationController =
      new TextEditingController();
  TextEditingController OTPvarificaionController = new TextEditingController();
  String countryCode = "+880";
  void handelOTPsubmit(String userID, BuildContext context) {
    if (_formkey.currentState!.validate()) {
      loginwithOTP(otp: OTPvarificaionController.text, userId: userID)
          .then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('login feild')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/chat.png',
                  ),
                ),
                Text(
                  'Welcome to FirstChat💃',
                  style:
                      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Enter your phone number to continue',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Form(
                  key: _formkey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.length != 10) {
                        return 'Invalid phone number';
                      }
                    },
                    controller: PhoneNumberVarificationController,
                    decoration: InputDecoration(
                      prefixIcon: CountryCodePicker(
                        initialSelection: 'BD',
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.r, vertical: 12.r),
                      labelText: 'Enter your phone number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  height: 20.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        createPhonesession(
                                phone: countryCode +
                                    PhoneNumberVarificationController.text)
                            .then((value) {
                          if (value != "login_error") {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('OTP Varification'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Enter the 6 digit OTP'),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Form(
                                      key: _formkey1,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: OTPvarificaionController,
                                        validator: (value) {
                                          if (value!.length != 6) {
                                            return 'Invalid OTP';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          labelText:
                                              'Enter the OTP varification',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.r, vertical: 12.r),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      handelOTPsubmit(value, context);
                                    },
                                    child: Text('Submit'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Feild to sent OTP')));
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kprimarycolor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text(
                      'Sent OTP',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
