class SubDomainModel {
  int? status;
  List<Subdomains>? subdomains;

  SubDomainModel({status, subdomains});

  SubDomainModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['subdomains'] != null) {
      subdomains = [];
      json['subdomains'].forEach((v) {
        subdomains!.add(Subdomains.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (subdomains != null) {
      data['subdomains'] = subdomains!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'SubDomainModel(status: $status, subdomains: $subdomains)';
  }
}

class Subdomains {
  String? title;
  String? status;
  List<String>? image;
  String? description;
  List<BasicItemId>? basicItemId;
  int? viewCount;
  String? sId;

  Subdomains({title, status, image, description, basicItemId, viewCount, sId});

  Subdomains.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    status = json['status'];
    image = json['image'].cast<String>();
    description = json['description'];
    if (json['basicItemId'] != null) {
      basicItemId = [];
      json['basicItemId'].forEach((v) {
        basicItemId!.add(BasicItemId.fromJson(v));
      });
    }
    viewCount = json['viewCount'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['status'] = status;
    data['image'] = image;
    data['description'] = description;
    if (basicItemId != null) {
      data['basicItemId'] = basicItemId!.map((v) => v.toJson()).toList();
    }
    data['viewCount'] = viewCount;
    data['_id'] = sId;
    return data;
  }

  @override
  String toString() {
    return 'Subdomains(title: $title, status: $status, image: $image, description: $description, basicItemId: $basicItemId, viewCount: $viewCount, sId: $sId)';
  }
}

class BasicItemId {
  String? sId;
  String? icon;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BasicItemId({sId, icon, name, createdAt, updatedAt, iV});

  BasicItemId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    icon = json['icon'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['icon'] = icon;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }

  @override
  String toString() {
    return 'BasicItemId(sId: $sId, icon: $icon, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, iV: $iV)';
  }
}



// class SubDomainModel {
//   int? status;
//   String? message;
//   List<Subdomains>? subdomains;

//   SubDomainModel({this.status, this.message, this.subdomains});

//   SubDomainModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     subdomains = json['subdomains'] != null
//         ? (json['subdomains'] as List)
//             .map((v) => Subdomains.fromJson(v))
//             .toList()
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'message': message,
//       'subdomains': subdomains?.map((v) => v.toJson()).toList(),
//     };
//   }

//   @override
//   String toString() {
//     return 'SubDomainModel(status: $status, message: $message, subdomains: $subdomains)';
//   }
// }

// class Subdomains {
//   List<String>? basicItemId;
//   int? viewCount;
//   String? title;
//   String? status;
//   List<String>? image;
//   String? sId;

//   Subdomains({
//     this.basicItemId,
//     this.viewCount,
//     this.title,
//     this.status,
//     this.image,
//     this.sId,
//   });

//   Subdomains.fromJson(Map<String, dynamic> json) {
//     basicItemId = json['basicItemId'] != null
//         ? List<String>.from(json['basicItemId'])
//         : null;
//     viewCount = json['viewCount'];
//     title = json['title'];
//     status = json['status'];
//     image = json['image'] != null ? List<String>.from(json['image']) : null;
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'basicItemId': basicItemId,
//       'viewCount': viewCount,
//       'title': title,
//       'status': status,
//       'image': image,
//       '_id': sId,
//     };
//   }

//   @override
//   String toString() {
//     return 'Subdomains(basicItemId: $basicItemId, viewCount: $viewCount, title: $title, status: $status, image: $image, sId: $sId)';
//   }
// }
