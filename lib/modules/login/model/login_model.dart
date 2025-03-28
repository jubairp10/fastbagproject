class LoginResponce {
  String? message;
  User? user;
  String? accessToken;

  LoginResponce({this.message, this.user, this.accessToken});

  LoginResponce.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['access_token'] = this.accessToken;
    return data;
  }
}

class User {
  String? mobileNumber;
  Null? name;
  bool? isVerified;

  User({this.mobileNumber, this.name, this.isVerified});

  User.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobile_number'];
    name = json['name'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile_number'] = this.mobileNumber;
    data['name'] = this.name;
    data['is_verified'] = this.isVerified;
    return data;
  }
}
