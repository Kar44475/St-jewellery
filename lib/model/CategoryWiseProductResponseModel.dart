class CategoryWiseProductResponseModel {
  final bool success;
  final String message;
  final CategoryWiseProductData data;

  CategoryWiseProductResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CategoryWiseProductResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryWiseProductResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: CategoryWiseProductData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class CategoryWiseProductData {
  final int status;
  final List<CategoryWiseProduct> productList;

  CategoryWiseProductData({required this.status, required this.productList});

  factory CategoryWiseProductData.fromJson(Map<String, dynamic> json) {
    return CategoryWiseProductData(
      status: json['status'] ?? 0,
      productList:
          (json['product_list'] as List<dynamic>?)
              ?.map(
                (item) =>
                    CategoryWiseProduct.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'product_list': productList.map((product) => product.toJson()).toList(),
    };
  }
}

class CategoryWiseProduct {
  final int id;
  final int branchId;
  final int categoryId;
  final String productName;
  final String productImage;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int stars;
  final String category;

  CategoryWiseProduct({
    required this.id,
    required this.branchId,
    required this.categoryId,
    required this.productName,
    required this.productImage,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.stars,
    required this.category,
  });

  factory CategoryWiseProduct.fromJson(Map<String, dynamic> json) {
    return CategoryWiseProduct(
      id: json['id'] ?? 0,
      branchId: json['branchId'] ?? 0,
      categoryId: json['categoryId'] ?? 0,
      productName: json['product_name'] ?? '',
      productImage: json['product_image'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      stars: json['stars'] ?? 0,
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branchId': branchId,
      'categoryId': categoryId,
      'product_name': productName,
      'product_image': productImage,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'stars': stars,
      'category': category,
    };
  }
}
