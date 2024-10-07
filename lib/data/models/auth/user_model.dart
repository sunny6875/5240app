class UserModel {
  int? status;
  String? message;
  String? token;
  User? user;

  UserModel({this.status, this.message, this.token, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'UserModel(status: $status, message: $message, token: $token, user: $user)';
  }
}

class User {
  String? id;
  String? userName;
  String? email;
  bool? isDomainProvider;
  bool? isDomainAdded;
  String? domainId;

  User({
    this.id,
    this.userName,
    this.email,
    this.isDomainProvider,
    this.isDomainAdded,
    this.domainId,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['userEmail'];
    isDomainProvider = json['isDomainProvider'];
    isDomainAdded = json['isDomainAdded'];
    domainId = json['domainId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['userEmail'] = email;
    data['isDomainProvider'] = isDomainProvider;
    data['isDomainAdded'] = isDomainAdded;
    data['domainId'] = domainId;
    return data;
  }

  @override
  String toString() {
    return 'User(id: $id, userName: $userName, email: $email, isDomainProvider: $isDomainProvider,isDomainAdded:$isDomainAdded,domainId:$domainId)';
  }
}
