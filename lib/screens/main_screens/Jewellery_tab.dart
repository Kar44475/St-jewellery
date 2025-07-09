import 'package:flutter/material.dart';
import 'package:stjewellery/model/categorymodel.dart';
import 'package:stjewellery/model/allproductmodel.dart';
import 'package:stjewellery/model/CategoryWiseProductResponseModel.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/service/dashboard_service.dart';

class JewelleryTab extends StatefulWidget {
  const JewelleryTab({Key? key}) : super(key: key);

  @override
  State<JewelleryTab> createState() => _JewelleryTabState();
}

class _JewelleryTabState extends State<JewelleryTab> {
  List<Category> categories = [];
  List<AllProduct> allProducts = [];
  List<CategoryWiseProduct> categoryProducts = [];
  List<dynamic> currentProducts = [];

  int selectedCategoryIndex = 0;
  bool isLoadingProducts = false;
  bool isDataLoaded = false;
  bool _hasInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasInitialized) {
      _hasInitialized = true;
      _loadJewelleryData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: !isDataLoaded
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading jewellery collection...',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildJewelleryBanner(),

                  SizedBox(height: 20),

                  _buildTitleSection(),

                  SizedBox(height: 20),

                  _buildCategoryFilter(),

                  SizedBox(height: 20),

                  _buildProductsGrid(),

                  SizedBox(height: 30),
                ],
              ),
            ),
    );
  }

  Widget _buildJewelleryBanner() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/pngIcons/instaimg2.png',
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.diamond, size: 80, color: Colors.white),
                      SizedBox(height: 10),
                      Text(
                        'Jewellery Collection',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),

            Positioned(
              bottom: 40,
              left: 30,
              right: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Exquisite Jewellery',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Discover our premium collection of handcrafted jewellery',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Collection',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Browse through our carefully curated jewellery pieces',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: 15),

        SizedBox(
          height: 70,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(children: _buildCategoryChips()),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String title, int index, IconData icon) {
    bool isSelected = selectedCategoryIndex == index;

    return GestureDetector(
      onTap: () async {
        setState(() {
          selectedCategoryIndex = index;
          isLoadingProducts = true;
        });

        try {
          if (index == 0) {
            await _loadAllProducts();
          } else {
            int categoryId = categories[index - 1].id;
            await _loadCategoryProducts(categoryId.toString());
          }
        } catch (e) {
          print("Error loading products: $e");
          _showErrorSnackBar("Error loading products: ${e.toString()}");
        } finally {
          setState(() {
            isLoadingProducts = false;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 15, top: 2, bottom: 2),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.8),
                    ],
                  )
                : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.grey[50]!],
                  ),
            borderRadius: BorderRadius.circular(25),

            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? Theme.of(context).primaryColor.withOpacity(0.25)
                    : Colors.grey.withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: isSelected ? 6 : 4,
                offset: Offset(0, isSelected ? 2 : 1),
              ),
            ],
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : Colors.grey[600],
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCategoryChips() {
    List<Widget> chips = [];

    chips.add(_buildCategoryChip("All Products", 0, Icons.apps));

    for (int i = 0; i < categories.length; i++) {
      chips.add(
        _buildCategoryChip(
          categories[i].category,
          i + 1,
          _getCategoryIcon(categories[i].category),
        ),
      );
    }

    return chips;
  }

  Widget _buildProductsGrid() {
    if (isLoadingProducts) {
      return Container(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Loading products...',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    if (currentProducts.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 60,
                color: Colors.grey[400],
              ),
              SizedBox(height: 16),
              Text(
                'No products found',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.8,
        ),
        itemCount: currentProducts.length,
        itemBuilder: (context, index) {
          final product = currentProducts[index];
          return _buildProductCard(product);
        },
      ),
    );
  }

  Widget _buildProductCard(dynamic product) {
    return GestureDetector(
      onTap: () {
        // Navigate to product details
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ProductDetailsEcom(data: product),
        //   ),
        // );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        ApiConfigs.imageurls + _getProductImage(product),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,

                        right: 0,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getProductName(product),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          _getProductDescription(product),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getProductImage(dynamic product) {
    if (product is AllProduct) {
      return product.productImage;
    } else if (product is CategoryWiseProduct) {
      return product.productImage;
    }
    return '';
  }

  String _getProductName(dynamic product) {
    if (product is AllProduct) {
      return product.productName;
    } else if (product is CategoryWiseProduct) {
      return product.productName;
    }
    return '';
  }

  String _getProductDescription(dynamic product) {
    if (product is AllProduct) {
      return product.description;
    } else if (product is CategoryWiseProduct) {
      return product.description;
    }
    return '';
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'rings':
        return Icons.radio_button_unchecked;
      case 'necklace':
      case 'necklaces':
        return Icons.favorite;
      case 'earrings':
        return Icons.hearing;
      case 'bracelets':
      case 'bangles':
        return Icons.watch;
      case 'chains':
        return Icons.link;
      case 'pendants':
        return Icons.diamond;
      default:
        return Icons.star;
    }
  }

  Future<void> _loadJewelleryData() async {
    try {
      setState(() {
        isDataLoaded = false;
      });

      CategoryProductResponseModel categoryData =
          await Dashbordservice.getDashboardCatgory();

      AllProductsResponseModel allProductsResponse =
          await Dashbordservice.getAllProduct();

      if (categoryData.success && allProductsResponse.success) {
        setState(() {
          categories = categoryData.data.categoryList;
          allProducts = allProductsResponse.data.allProductList;
          currentProducts = allProductsResponse.data.allProductList;
          isDataLoaded = true;
        });
      } else {
        setState(() {
          isDataLoaded = true;
        });
        _showErrorSnackBar("Failed to load jewellery data");
      }
    } catch (e) {
      print("Error loading jewellery data: $e");
      setState(() {
        isDataLoaded = true;
      });
      _showErrorSnackBar("Error loading jewellery data: ${e.toString()}");
    }
  }

  Future<void> _loadAllProducts() async {
    try {
      AllProductsResponseModel allProductsResponse =
          await Dashbordservice.getAllProduct();

      if (allProductsResponse.success) {
        setState(() {
          allProducts = allProductsResponse.data.allProductList;
          currentProducts = allProducts;
        });
      } else {
        _showErrorSnackBar("Failed to load all products");
      }
    } catch (e) {
      print("Error loading all products: $e");
      throw e;
    }
  }

  Future<void> _loadCategoryProducts(String categoryId) async {
    try {
      CategoryWiseProductResponseModel categoryProductsResponse =
          await Dashbordservice.getByCategoryProduct(categoryId);

      if (categoryProductsResponse.success) {
        setState(() {
          categoryProducts = categoryProductsResponse.data.productList;
          currentProducts = categoryProducts;
        });
      } else {
        _showErrorSnackBar("Failed to load category products");
      }
    } catch (e) {
      print("Error loading category products: $e");
      throw e;
    }
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }
}
