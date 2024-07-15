class UserData {
  UserData({
    this.uid,
    this.name,
    this.emailId,
    this.phoneNumber,
    this.photoUrl,
  });
  String? uid;
  String? name;
  String? emailId;
  String? phoneNumber;
  String? photoUrl;

  UserData.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ?? "";
    name = json['name'] ?? "";
    emailId = json['emailId'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    photoUrl = json['photoUrl'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['emailId'] = emailId;
    data['phoneNumber'] = phoneNumber;
    data['photoUrl'] = photoUrl;
    return data;
  }
}
