class BasicItem {
  int? status;
  List<BasicItems>? basicItems;

  BasicItem({this.status, this.basicItems});

  BasicItem.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['basicItems'] != null) {
      basicItems = [];
      json['basicItems'].forEach((v) {
        basicItems!.add(BasicItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (basicItems != null) {
      data['basicItems'] = basicItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'BasicItem{status: $status, basicItems: $basicItems}';
  }
}

class BasicItems {
  String? sId;
  String? icon;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BasicItems(
      {this.sId,
      this.icon,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BasicItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    icon = json['icon'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    return 'BasicItems{sId: $sId, icon: $icon, name: $name, '
        'createdAt: $createdAt, updatedAt: $updatedAt, iV: $iV}';
  }
}
