class Userdata {
  final String? name;
  final String phone;
  final String userId;
  final String? profilepic;
  final String? devicetoken;
  final bool? isOnline;
  Userdata(
      {this.name,
      required this.phone,
      required this.userId,
      this.profilepic,
      this.devicetoken,
      this.isOnline});

  // to convart document data to userdata
  factory Userdata.toMap(Map<String, dynamic> Map) {
    return Userdata(
        phone: Map["Phone_no"] ?? "",
        userId: Map["	userID"] ?? "",
        name: Map["name"] ?? "",
        devicetoken: Map["Device_token"] ?? "",
        isOnline: Map["isOnline"] ?? false,
        profilepic: Map["Profile_pic"] ?? "");
  }
}
