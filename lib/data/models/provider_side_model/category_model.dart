class CategoryModel {
  int? status;
  List<CategoryList>? categoryList;

  CategoryModel({this.status, this.categoryList});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['category_list'] != null) {
      categoryList = [];
      json['category_list'].forEach((v) {
        categoryList!.add(CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (categoryList != null) {
      data['category_list'] = categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'CategoryModel(status: $status, categoryList: $categoryList)';
  }
}

class CategoryList {
  String? sId;
  String? categoryName;
  String? categoryIcon;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? title;
  String? image;

  CategoryList(
      {this.sId,
      this.categoryName,
      this.categoryIcon,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.title,
      this.image});

  CategoryList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['categoryName'];
    categoryIcon = json['categoryIcon'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['categoryName'] = categoryName;
    data['categoryIcon'] = categoryIcon;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['title'] = title;
    data['image'] = image;
    return data;
  }

  @override
  String toString() {
    return 'CategoryList(sId: $sId, categoryName: $categoryName, title: $title, image: $image)';
  }
}
