class DomainModel {
  int? status;
  Domain? domain;

  DomainModel({this.status, this.domain});

  DomainModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    domain = json['domain'] != null ? Domain.fromJson(json['domain']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (domain != null) {
      data['domain'] = domain!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'DomainModel(status: $status, domain: $domain)';
  }
}

class Domain {
  Location? location;
  String? sId;
  String? title;
  List<String>? image;
  String? status;
  CategoryId? categoryId;
  String? description;
  List<dynamic>? likedBy; // Changed from List<Null> to List<dynamic>
  int? viewCount;
  UserId? userId;
  List<dynamic>? subdomains; // Changed from List<Null> to List<dynamic>
  int? iV;

  Domain({
    this.location,
    this.sId,
    this.title,
    this.image,
    this.status,
    this.categoryId,
    this.description,
    this.likedBy,
    this.viewCount,
    this.userId,
    this.subdomains,
    this.iV,
  });

  Domain.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    title = json['title'];
    image = List<String>.from(json['image'] ?? []);
    status = json['status'];
    categoryId = json['categoryId'] != null
        ? CategoryId.fromJson(json['categoryId'])
        : null;
    description = json['description'];
    likedBy = json['likedBy'] ?? [];
    viewCount = json['viewCount'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    subdomains = json['subdomains'] ?? [];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['title'] = title;
    data['image'] = image;
    data['status'] = status;
    if (categoryId != null) {
      data['categoryId'] = categoryId!.toJson();
    }
    data['description'] = description;
    if (likedBy != null) {
      data['likedBy'] = likedBy;
    }
    data['viewCount'] = viewCount;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    if (subdomains != null) {
      data['subdomains'] = subdomains;
    }
    data['__v'] = iV;
    return data;
  }

  @override
  String toString() {
    return 'Domain(location: $location, sId: $sId, title: $title, image: $image, status: $status, categoryId: $categoryId, description: $description, likedBy: $likedBy, viewCount: $viewCount, userId: $userId, subdomains: $subdomains, iV: $iV)';
  }
}

class Location {
  String? name;
  double? latitude;
  double? longitude;

  Location({this.name, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }

  @override
  String toString() {
    return 'Location(name: $name, latitude: $latitude, longitude: $longitude)';
  }
}

class CategoryId {
  String? sId;
  String? categoryName;

  CategoryId({this.sId, this.categoryName});

  CategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['categoryName'] = categoryName;
    return data;
  }

  @override
  String toString() {
    return 'CategoryId(sId: $sId, categoryName: $categoryName)';
  }
}

class UserId {
  String? sId;
  String? userName;
  String? userEmail;
  String? password;
  bool? isDomainProvider;
  bool? isActive;
  List<dynamic>? likedDomains; // Changed from List<Null> to List<dynamic>
  String? otpCode;
  String? otpExpiry;
  dynamic resetPasswordOTP; // Changed from Null to dynamic
  dynamic resetPasswordExpires; // Changed from Null to dynamic
  bool? isDomainAdded;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? userProfile;

  UserId({
    this.sId,
    this.userName,
    this.userEmail,
    this.password,
    this.isDomainProvider,
    this.isActive,
    this.likedDomains,
    this.otpCode,
    this.otpExpiry,
    this.resetPasswordOTP,
    this.resetPasswordExpires,
    this.isDomainAdded,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.userProfile,
  });

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    password = json['password'];
    isDomainProvider = json['isDomainProvider'];
    isActive = json['isActive'];
    likedDomains = json['likedDomains'] ?? [];
    otpCode = json['otpCode'];
    otpExpiry = json['otpExpiry'];
    resetPasswordOTP = json['resetPasswordOTP'];
    resetPasswordExpires = json['resetPasswordExpires'];
    isDomainAdded = json['isDomainAdded'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    userProfile = json['userProfile'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    data['userEmail'] = userEmail;
    data['password'] = password;
    data['isDomainProvider'] = isDomainProvider;
    data['isActive'] = isActive;
    data['likedDomains'] = likedDomains;
    data['otpCode'] = otpCode;
    data['otpExpiry'] = otpExpiry;
    data['resetPasswordOTP'] = resetPasswordOTP;
    data['resetPasswordExpires'] = resetPasswordExpires;
    data['isDomainAdded'] = isDomainAdded;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['userProfile'] = userProfile;
    return data;
  }

  @override
  String toString() {
    return 'UserId(sId: $sId, userName: $userName, userEmail: $userEmail, password: $password, isDomainProvider: $isDomainProvider, isActive: $isActive, likedDomains: $likedDomains, otpCode: $otpCode, otpExpiry: $otpExpiry, resetPasswordOTP: $resetPasswordOTP, resetPasswordExpires: $resetPasswordExpires, isDomainAdded: $isDomainAdded, createdAt: $createdAt, updatedAt: $updatedAt, iV: $iV, userProfile: $userProfile)';
  }
}
