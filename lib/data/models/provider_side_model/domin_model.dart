class Domin {
  int? status;
  Domain? domain;

  Domin({this.status, this.domain});

  Domin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    domain = json['domain'] != null ? Domain.fromJson(json['domain']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (domain != null) {
      data['domain'] = domain!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Domin(status: $status, domain: $domain)';
  }
}

class Domain {
  Location? location;
  String? sId;
  String? title;
  List<String>? image;
  String? status;
  CategoryId? categoryId;
  int? viewCount;
  UserId? userId;
  List<Subdomains>? subdomains;
  int? iV;
  List<dynamic>? likedBy;

  Domain(
      {this.location,
        this.sId,
        this.title,
        this.image,
        this.status,
        this.categoryId,
        this.viewCount,
        this.userId,
        this.subdomains,
        this.iV,
        this.likedBy});

  Domain.fromJson(Map<String, dynamic> json) {
    location =
    json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    title = json['title'];
    image = json['image'].cast<String>();
    status = json['status'];
    categoryId = json['categoryId'] != null
        ? CategoryId.fromJson(json['categoryId'])
        : null;
    viewCount = json['viewCount'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    if (json['subdomains'] != null) {
      subdomains = <Subdomains>[];
      json['subdomains'].forEach((v) {
        subdomains!.add(Subdomains.fromJson(v));
      });
    }
    iV = json['__v'];
    likedBy = json['likedBy'] != null ? List<dynamic>.from(json['likedBy']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['viewCount'] = viewCount;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    if (subdomains != null) {
      data['subdomains'] = subdomains!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    if (likedBy != null) {
      data['likedBy'] = likedBy;
    }
    return data;
  }

  @override
  String toString() {
    return 'Domain(location: $location, sId: $sId, title: $title, image: $image, status: $status, categoryId: $categoryId, viewCount: $viewCount, userId: $userId, subdomains: $subdomains, iV: $iV, likedBy: $likedBy)';
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? otpCode;
  String? otpExpiry;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? userProfile;
  List<dynamic>? likedDomains;

  UserId(
      {this.sId,
        this.userName,
        this.userEmail,
        this.password,
        this.isDomainProvider,
        this.isActive,
        this.otpCode,
        this.otpExpiry,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.userProfile,
        this.likedDomains});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    password = json['password'];
    isDomainProvider = json['isDomainProvider'];
    isActive = json['isActive'];
    otpCode = json['otpCode'];
    otpExpiry = json['otpExpiry'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    userProfile = json['userProfile'];
    likedDomains =
    json['likedDomains'] != null ? List<dynamic>.from(json['likedDomains']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userName'] = userName;
    data['userEmail'] = userEmail;
    data['password'] = password;
    data['isDomainProvider'] = isDomainProvider;
    data['isActive'] = isActive;
    data['otpCode'] = otpCode;
    data['otpExpiry'] = otpExpiry;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['userProfile'] = userProfile;
    if (likedDomains != null) {
      data['likedDomains'] = likedDomains;
    }
    return data;
  }

  @override
  String toString() {
    return 'UserId(sId: $sId, userName: $userName, userEmail: $userEmail, password: $password, isDomainProvider: $isDomainProvider, isActive: $isActive, otpCode: $otpCode, otpExpiry: $otpExpiry, createdAt: $createdAt, updatedAt: $updatedAt, iV: $iV, userProfile: $userProfile, likedDomains: $likedDomains)';
  }
}

class Subdomains {
  List<dynamic>? basicItemId;
  String? title;
  String? status;
  List<String>? image;
  String? sId;
  int? viewCount;

  Subdomains(
      {this.basicItemId, this.title, this.status, this.image, this.sId, this.viewCount});

  Subdomains.fromJson(Map<String, dynamic> json) {
    basicItemId =
    json['basicItemId'] != null ? List<dynamic>.from(json['basicItemId']) : null;
    title = json['title'];
    status = json['status'];
    image = json['image'].cast<String>();
    sId = json['_id'];
    viewCount = json['viewCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (basicItemId != null) {
      data['basicItemId'] = basicItemId;
    }
    data['title'] = title;
    data['status'] = status;
    data['image'] = image;
    data['_id'] = sId;
    data['viewCount'] = viewCount;
    return data;
  }

  @override
  String toString() {
    return 'Subdomains(basicItemId: $basicItemId, title: $title, status: $status, image: $image, sId: $sId, viewCount: $viewCount)';
  }
}
