class ProfileModel {
  String? status;
  String? message;
  User? user;

  ProfileModel({this.status, this.message, this.user});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ProfileModel{status: $status, message: $message, user: $user}';
  }
}

class User {
  String? id;
  String? userName;
  String? email;
  bool? isDomainProvider;
  String? userProfile;
  Location? location;
  List<String>? likedDomains;
  bool? isDomainAdded;

  User({
    this.id,
    this.userName,
    this.email,
    this.isDomainProvider,
    this.userProfile,
    this.location,
    this.likedDomains,
    this.isDomainAdded,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    isDomainProvider = json['isDomainProvider'];
    userProfile = json['userProfile'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    likedDomains = json['likedDomains'].cast<String>();
    isDomainAdded = json['isDomainAdded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['email'] = email;
    data['isDomainProvider'] = isDomainProvider;
    data['userProfile'] = userProfile;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['likedDomains'] = likedDomains;
    data['isDomainAdded'] = isDomainAdded;
    return data;
  }

  @override
  String toString() {
    return 'User{id: $id, userName: $userName, email: $email, isDomainProvider: $isDomainProvider, '
        'userProfile: $userProfile, location: $location, likedDomains: $likedDomains, '
        'isDomainAdded: $isDomainAdded}';
  }
}

class Location {
  String? sId;
  String? userId;
  LocationDetails? location;
  int? iV;

  Location({this.sId, this.userId, this.location, this.iV});

  Location.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    location = json['location'] != null
        ? LocationDetails.fromJson(json['location'])
        : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['__v'] = iV;
    return data;
  }

  @override
  String toString() {
    return 'Location{sId: $sId, userId: $userId, location: $location, iV: $iV}';
  }
}

class LocationDetails {
  String? latitude;
  String? longitude;
  String? sId;

  LocationDetails({this.latitude, this.longitude, this.sId});

  LocationDetails.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['_id'] = sId;
    return data;
  }

  @override
  String toString() {
    return 'LocationDetails{latitude: $latitude, longitude: $longitude, sId: $sId}';
  }
}
