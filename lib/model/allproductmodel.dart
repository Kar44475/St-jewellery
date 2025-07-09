class AllProductsResponseModel {
  final bool success;
  final String message;
  final AllProductsData data;

  AllProductsResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AllProductsResponseModel.fromJson(Map<String, dynamic> json) {
    return AllProductsResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: AllProductsData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class AllProductsData {
  final int status;
  final List<AllProduct> allProductList;

  AllProductsData({required this.status, required this.allProductList});

  factory AllProductsData.fromJson(Map<String, dynamic> json) {
    return AllProductsData(
      status: json['status'] ?? 0,
      allProductList:
          (json['All_product_list'] as List<dynamic>?)
              ?.map((item) => AllProduct.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'All_product_list': allProductList
          .map((product) => product.toJson())
          .toList(),
    };
  }
}

class AllProduct {
  final int id;
  final int branchId;
  final int categoryId;
  final String productName;
  final String productImage;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int stars;

  AllProduct({
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

  factory AllProduct.fromJson(Map<String, dynamic> json) {
    return AllProduct(
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
