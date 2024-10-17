import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/Providers/user_data_provider.dart';
import 'package:chatapp/constant/Colors.dart';
import 'package:chatapp/controller/appwrite_controller.dart';
import 'package:chatapp/viwes/HomePage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  FilePickerResult? filePickerResult;
  late String? imageID = "";
  late String? userID = "";
  final namekey = GlobalKey<FormState>();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {});
    // try to lead the data form local database
    Provider.of<UserDataProvider>(context, listen: false).loadDatafromLocal();
    imageID =
        Provider.of<UserDataProvider>(context, listen: false).getuserProfile;
    userID = Provider.of<UserDataProvider>(context, listen: false).getuserId;
    Provider.of<UserDataProvider>(context, listen: false);
    super.initState();
  }

// to open file picker
  void _openfilepicker() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    setState(() {
      filePickerResult = result;
    });
  }

  // Upload user profile images and save it to bucket and database
  Future<void> UploadProfileImage() async {
    try {
      if (filePickerResult != null && filePickerResult!.files.isNotEmpty) {
        PlatformFile file = filePickerResult!.files.first;
        final fileBytes = await File(file.path!).readAsBytes();
        final inputFile =
            InputFile.fromBytes(bytes: fileBytes, filename: file.name);

        // If an image already exists for the user profile, update it; otherwise, upload a new image
        if (imageID != null && imageID!.isNotEmpty) {
          // Update the existing image
          final newImageId =
              await UpdateImageOnBacket(oldImageId: imageID!, image: inputFile);
          if (newImageId != null) {
            imageID = newImageId; // Update image ID after a successful upload
          }
        } else {
          // Upload a new image if no image exists
          final newImageId = await saveImageToBucket(image: inputFile);
          if (newImageId != null) {
            imageID = newImageId; // Update image ID after a successful upload
          }
        }
      } else {
        print("No file selected or filePickerResult is null.");
      }
    } catch (e) {
      print("Error on uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> datapassed =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Consumer<UserDataProvider>(
      builder: (context, value, child) {
        _nameController.text = value.getuserName;
        _phoneController.text = value.getUserPhone;
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
              datapassed["title"] == "edit" ? "Update" : "add Details",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              GestureDetector(
                onTap: _openfilepicker,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 120,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: filePickerResult != null
                          ? Image(
                                  image: FileImage(File(
                                      filePickerResult!.files.first.path!)))
                              .image
                          : value.getuserProfile != "" &&
                                  value.getuserProfile != null
                              ? CachedNetworkImageProvider(
                                  "https://cloud.appwrite.io/v1/storage/buckets/670ce544003d21242221/files/${value.getuserProfile}/view?project=670b65b9001728ab8104&project=670b65b9001728ab8104&mode=admin")
                              : null,
                    ),
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
                child: Form(
                  key: namekey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) return "Cannot be empty";

                      return null;
                    },
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Enter your name'),
                  ),
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
                      onPressed: () async {
                        if (namekey.currentState!.validate()) {
                          // Upload the profile image if a file is selected
                          if (filePickerResult != null) {
                            await UploadProfileImage(); // Make sure to await this
                          }

                          // Save the data to the database collection (user details)
                          await updateDatauserdetails(
                            imageID ??
                                "", // Use the updated imageID after uploading
                            userId: userID!,
                            name: _nameController.text,
                          );

                          // Navigate to the Home Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      },
                      child: Text(datapassed["title"] == "edit"
                          ? "Update"
                          : "Continue"),
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
      },
    );
  }
}
