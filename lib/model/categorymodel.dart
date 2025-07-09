class CategoryProductResponseModel {
  final bool success;
  final String message;
  final ResponseData data;

  CategoryProductResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CategoryProductResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryProductResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ResponseData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class ResponseData {
  final int status;
  final List<Category> categoryList;
  final List<Product> latestProductList;

  ResponseData({
    required this.status,
    required this.categoryList,
    required this.latestProductList,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      status: json['status'] ?? 0,
      categoryList:
          (json['category_list'] as List<dynamic>?)
              ?.map((item) => Category.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      latestProductList:
          (json['Latest_product_list'] as List<dynamic>?)
              ?.map((item) => Product.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'category_list': categoryList
          .map((category) => category.toJson())
          .toList(),
      'Latest_product_list': latestProductList
          .map((product) => product.toJson())
          .toList(),
    };
  }
}

class Category {
  final int id;
  final int branchId;
  final String category;
  final String categoryImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.branchId,
    required this.category,
    required this.categoryImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      branchId: json['branchId'] ?? 0,
      category: json['category'] ?? '',
      categoryImage: json['category_image'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branchId': branchId,
      'category': category,
      'category_image': categoryImage,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Product {
  final int id;
  final int branchId;
  final int categoryId;
  final String productName;
  final String productImage;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int stars;

  Product({
    required this.id,
    required this.branchId,
    required this.categoryId,
    required this.productName,
    required this.productImage,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.stars,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      branchId: json['branchId'] ?? 0,
      categoryId: json['categoryId'] ?? 0,
      productName: json['product_name'] ?? '',
      productImage: json['product_image'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      stars: json['stars'] ?? 0,
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
    };
  }
}
