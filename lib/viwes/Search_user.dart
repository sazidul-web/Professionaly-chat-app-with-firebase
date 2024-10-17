import 'package:appwrite/models.dart';
import 'package:chatapp/Models/userData.dart';
import 'package:chatapp/Providers/user_data_provider.dart';
import 'package:chatapp/constant/Colors.dart';
import 'package:chatapp/controller/appwrite_controller.dart';
import 'package:chatapp/viwes/Chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserSearch extends StatefulWidget {
  @override
  State<UserSearch> createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  TextEditingController _searchController = TextEditingController();
  late DocumentList searchuser = DocumentList(total: -1, documents: []);

  void _handelSearch() {
    searchUsers(
            searchItem: _searchController.text,
            userId:
                Provider.of<UserDataProvider>(context, listen: false).getuserId)
        .then((value) {
      if (value != null) {
        setState(() {
          searchuser = value;
        });
      } else {
        setState(() {
          searchuser = DocumentList(total: 0, documents: []);
        });
      }
    });
  }

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
                    controller: _searchController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter phone number'),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _handelSearch();
                    },
                    icon: Icon(Icons.search)),
              ],
            ),
          ),
        ),
      ),
      body: searchuser.total == -1
          ? Center(
              child: Text('Use the search box to search for users'),
            )
          : searchuser.total == 0
              ? Center(
                  child: Text('No user found'),
                )
              : ListView.builder(
                  itemCount: searchuser.documents.length,
                  itemBuilder: (context, index) {
                    var document = searchuser.documents[index].data;
                    return ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, "/chat",
                            arguments: Userdata.toMap(
                                searchuser.documents[index].data));
                      },
                      leading: CircleAvatar(
                          backgroundImage: document["Profile_pic"] != null &&
                                  document["Profile_pic"].isNotEmpty
                              ? NetworkImage(
                                  'https://cloud.appwrite.io/v1/storage/buckets/670ce544003d21242221/files/${document["Profile_pic"]}/view?project=670b65b9001728ab8104')
                              : AssetImage('assets/user.png')),
                      title: Text(document["name"] ?? "No name"),
                      subtitle: Text(document["Phone_no"] ?? "No phone number"),
                      trailing: Text(searchuser.documents[index].$id),
                    );
                  },
                ),
    );
  }
}
