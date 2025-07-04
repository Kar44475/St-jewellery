import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/ECommerceModule/Data/ProductsData.dart';
import 'package:stjewellery/ECommerceModule/ProductDetailsPage.dart';
import 'package:stjewellery/Utils/Utils.dart';
import 'package:stjewellery/Utils/starRating.dart';
import 'package:stjewellery/model/offerModel.dart';
import 'package:stjewellery/model/categorymodel.dart';
import 'package:stjewellery/model/allproductmodel.dart';
import 'package:stjewellery/model/CategoryWiseProductResponseModel.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/screens/Login_OTP/LoginScreen.dart';
import 'package:stjewellery/service/Dashboardservice.dart';
import 'package:stjewellery/service/offerservice.dart';

import '../model/Dashboardmodel.dart' as model;

class GuestLoginScreen extends StatefulWidget {
  const GuestLoginScreen({Key? key}) : super(key: key);

  @override
  State<GuestLoginScreen> createState() => _GuestLoginScreenState();
}

class _GuestLoginScreenState extends State<GuestLoginScreen> {
  List<String> imageList = [];
  List<String> imageList1 = [];
  String? gram;
  String? gramSilver;
  String? change;
  String? changeSilver;
  bool updown = false;
  bool updownSilver = false;
  int selectedIndex = 0;

  model.Dashboardmodel? data;
  CategoryProductResponseModel? categoryProductData;
  AllProductsResponseModel? allProductsData;
  List<Category> categories = [];
  List<AllProduct> allProducts = [];
  List<CategoryWiseProduct> categoryProducts = [];
  
  List<dynamic> currentProducts = [];
  bool isLoadingProducts = false;

  bool loaded = false;
  
  // Flags to track what data is available
  bool hasGoldRateData = false;
  bool hasCategoryData = false;
  bool hasProductData = false;
  bool hasOfferData = false;

  double width = 0;
  bool myAnimation = false;
  String? today;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        myAnimation = true;
      });
    });
    Future.delayed(Duration.zero, () {
      getUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    var ss = MediaQuery.of(context).size;

    return Scaffold(  
      body: !loaded
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
           appBar: AppBar(
  backgroundColor: Theme.of(context).primaryColor,
  elevation: 0,     
  title: Image.asset(
    "assets/pngIcons/mainIcons.png",
    height: 55,
  ),
  // leading: IconButton(
  //   icon: Icon(Icons.menu, color: Colors.white),
  //   onPressed: () {
  //     _showGuestBottomDrawer(context);
  //   },
  // ),
  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: TextButton.icon(
        onPressed: () {
          _navigateToLogin();
        },
        icon: Icon(
          Icons.login,
          color: Colors.white,
          size: 20,
        ),
        label: Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
      ),
    ),
  ],
),

              body: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hero Image Section (Always show)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/pngIcons/dashboardimage.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Every Ornament Tells a Story.\nLet Yours Begin in Gold.",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ),
                      ),
                
                      // Gold Rate Section - Only show if data is available
                      if (hasGoldRateData && data != null)
                        Container(
                          width: double.infinity,
                          color: Color.fromRGBO(255, 197, 19, 1),
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                              flex: 12,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/pngIcons/coinIcon.png",
                                      height: 35,
                                      width: 35,
                                    ),
                                    SizedBox(width: 6),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Gold Rate",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            today ?? "",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 9,
                                child: Column(
                                  children: [
                                    Text(
                                      "₹${data!.data.todayRate.toString().split(".")[0]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "1 Gram",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 9,
                                child: Column(
                                  children: [
                                    Text(
                                      "₹${gram?.toString().split(".")[0] ?? "N/A"}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "8 Gram",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 9,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        change?.toString().split(".")[0] ?? "0",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(width: 3),
                                    Lottie.asset(
                                      updown ? "assets/up.json" : "assets/down.json",
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                
                      SizedBox(height: 10),
                
                      // Two Images Section (Always show - static content)
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/pngIcons/leftImageDashboard.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 15,
                                    right: 15,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "30",
                                          style: TextStyle(
                                            color: Color.fromRGBO(255, 197, 19, 1),
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            height: 1.0,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "%",
                                              style: TextStyle(
                                                color: Color.fromRGBO(255, 197, 19, 1),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                height: 1.0,
                                              ),
                                            ),
                                            Text(
                                              "off",
                                              style: TextStyle(
                                                color: Color.fromRGBO(255, 197, 19, 1),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                height: 1.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    left: 15,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Unique jewellery",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "collection",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/pngIcons/rightImageDashboard.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 15,
                                    right: 15,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "15",
                                          style: TextStyle(
                                            color: Color.fromRGBO(255, 197, 19, 1),
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            height: 1.0,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "%",
                                              style: TextStyle(
                                                color: Color.fromRGBO(255, 197, 19, 1),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                height: 1.0,
                                              ),
                                            ),
                                            Text(
                                              "off",
                                              style: TextStyle(
                                                color: Color.fromRGBO (255, 197, 19, 1),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                height: 1.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    left: 15,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Unique jewellery",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "collection",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                
                      SizedBox(height: 20),
                
                      // Category Tabs Section - Only show if categories are available
                      if (hasCategoryData && categories.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Container(
                            height: 50,
                            child: Column(
                              children: [
                                Container(
                                  height: 40,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: _buildCategoryTabs(),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  color: Colors.grey[300],
                                  child: Row(
                                    children: [
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        width: MediaQuery.of(context).size.width / (categories.length + 1),
                                        height: 2,
                                                                              margin: EdgeInsets.only(left: selectedIndex * MediaQuery.of(context).size.width / (categories.length + 1)),
                                        color: Theme.of(context).primaryColor,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                      // Products Section - Only show if products are available
                      if (hasProductData && currentProducts.isNotEmpty)
                        isLoadingProducts 
                          ? Container(
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final itemWidth = (constraints.maxWidth) / 2;
                                  final itemHeight = itemWidth * 1.05;
                                  final imgHeight = itemWidth * 0.65;
                                  final aspectRatio = itemWidth / itemHeight;

                                  return GridView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 0.0,
                                      mainAxisSpacing: 0.0,
                                      childAspectRatio: aspectRatio,
                                    ),
                                    itemCount: currentProducts.length > 4 ? 4 : currentProducts.length,
                                    itemBuilder: (context, index) {
                                      final product = currentProducts[index];
                                      return GestureDetector(
                                        onTap: () {
                                      //    _showLoginPrompt();
                                        },
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      height: imgHeight,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(ApiConfigs.imageurls + _getProductImage(product)),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius: const BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                    // Positioned.fill(
                                                    //   child: Container(
                                                    //     decoration: BoxDecoration(
                                                    //       color: Colors.black.withOpacity(0.3),
                                                    //       borderRadius: const BorderRadius.all(
                                                    //         Radius.circular(10),
                                                    //       ),
                                                    //     ),
                                                    //     child: Center(
                                                    //       child: Icon(
                                                    //         Icons.lock,
                                                    //         color: Colors.white,
                                                    //         size: 30,
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 8,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Text(
                                                        _getProductName(product),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: font(
                                                          12,
                                                          Colors.black,
                                                          FontWeight.w500,
                                                        ),
                                                      ),
                                                      h(5),
                                                      Text(
                                                        _getProductDescription(product),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: font(
                                                          10,
                                                          const Color(0xff787272),
                                                          FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),

                      SizedBox(height: 20),

                      // Login Call-to-Action Section (Always show)
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).primaryColor.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.account_circle,
                              size: 50,
                              color: Colors.white,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Join Our Community",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Login to access exclusive features, personalized recommendations, and special offers!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                _navigateToLogin();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Theme.of(context).primaryColor,
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.login, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    "Login Now",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Show message if no data is available
                      if (!hasGoldRateData && !hasProductData && !hasCategoryData)
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 50,
                                color: Colors.grey[600],
                              ),
                              SizedBox(height: 15),
                              Text(
                                "Limited Access",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Some features require authentication. Please login to access all content and features.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),

                      h(ScreenSize.setHeight(context, 0.1)),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  // Helper methods to get product properties from dynamic objects
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

  // Updated method to build category tabs with API data (same as home_screen.dart)
  List<Widget> _buildCategoryTabs() {
    List<Widget> tabs = [];
    
    // Add "All Products" as first tab
    tabs.add(_buildCategoryTab("All Products", 0));
    
    // Add categories from API
    for (int i = 0; i < categories.length; i++) {
      tabs.add(_buildCategoryTab(categories[i].category, i + 1));
    }
    
    return tabs;
  }

  Widget _buildCategoryTab(String title, int index) {
    int totalTabs = categories.length + 1; // +1 for "All Products"
    return InkWell(
      onTap: () async {
        setState(() {
          selectedIndex = index;
          isLoadingProducts = true;
        });
        
        try {
          if (index == 0) {
            // Load all products
            await _loadAllProducts();
          } else {
            // Load category-wise products
            int categoryId = categories[index - 1].id;
            await _loadCategoryProducts(categoryId.toString());
          }
        } catch (e) {
          print("Error loading products: $e");
          // Don't show error to guest users, just hide loading
        } finally {
          setState(() {
            isLoadingProducts = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width / totalTabs,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: selectedIndex == index 
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
                fontWeight: selectedIndex == index 
                  ? FontWeight.bold 
                  : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to load all products (same as home_screen.dart)
  Future<void> _loadAllProducts() async {
    try {
      AllProductsResponseModel allProductsResponse = await Dashbordservice.getAllProduct();
      
      if (allProductsResponse.success) {
        setState(() {
          allProducts = allProductsResponse.data.allProductList;
          currentProducts = allProducts;
          hasProductData = true;
        });
      }
    } catch (e) {
      print("Error loading all products: $e");
      setState(() {
        hasProductData = false;
        currentProducts = [];
      });
    }
  }

  // Method to load category-wise products (same as home_screen.dart)
  Future<void> _loadCategoryProducts(String categoryId) async {
    try {
      CategoryWiseProductResponseModel categoryProductsResponse = 
          await Dashbordservice.getByCategoryProduct(categoryId);
      
      if (categoryProductsResponse.success) {
        setState(() {
          categoryProducts = categoryProductsResponse.data.productList;
          currentProducts = categoryProducts;
          hasProductData = true;
        });
      }
    } catch (e) {
      print("Error loading category products: $e");
      setState(() {
        hasProductData = false;
        currentProducts = [];
      });
    }
  }

  Offermodel? reterive;

  getOffers() async {
    try {
      print("try");
      Offermodel reteriveData = await Offerservice.getOffers();
      print(reteriveData);
      setState(() {
        reterive = reteriveData;
        hasOfferData = true;
      });
    } catch (e) {
      print("Error loading offers: $e");
      setState(() {
        hasOfferData = false;
      });
    }
  }

  // Updated method with better error handling for guest users (following home_screen.dart pattern)
  Future<void> getUserDetails() async {
    await getOffers();
    today = DateFormat('dd  MMM, yyyy').format(DateTime.now());

    try {
      // Try to get dashboard data
      try {
        model.Dashboardmodel? datas = await Dashbordservice.getDashboard();
        if (datas.success) {
          print(datas.message);
          imageList = datas.data.bannerImage.map((e) => e.bannerImage).toList();
          imageList1 = datas.data.schemeImage.map((e) => e.bannerImage).toList();

          gram = (double.parse(datas.data.todayRate) * 8).toString();
          gramSilver = (double.parse(datas.data.silverTodayRate) * 8).toString();

          if (double.parse(datas.data.todayRate) >
              double.parse(datas.data.gramPrevious)) {
            change =
                ((double.parse(datas.data.todayRate) -
                            double.parse(datas.data.gramPrevious)) *
                        8)
                    .toString();
            updown = true;
          } else {
            change =
                ((double.parse(datas.data.gramPrevious) -
                            double.parse(datas.data.todayRate)) *
                        8)
                    .toString();
            updown = false;
          }

          if (double.parse(datas.data.silverTodayRate) >
              double.parse(datas.data.silverPrevious)) {
          

            changeSilver =
                ((double.parse(datas.data.silverTodayRate) -
                            double.parse(datas.data.silverPrevious)) *
                        8)
                    .toString();
            updownSilver = true;
          } else {
            changeSilver =
                ((double.parse(datas.data.silverPrevious) -
                            double.parse(datas.data.silverTodayRate)) *
                        8)
                    .toString();
            updownSilver = false;
          }

          setState(() {
            data = datas;
            hasGoldRateData = true;
          });
        }
      } catch (e) {
        print("Error loading dashboard data: $e");
        setState(() {
          hasGoldRateData = false;
        });
      }
      
      // Try to get category data
      try {
        CategoryProductResponseModel categoryData = await Dashbordservice.getDashboardCatgory();
        if (categoryData.success) {
          setState(() {
            categoryProductData = categoryData;
            categories = categoryData.data.categoryList;
            hasCategoryData = true;
          });
        }
      } catch (e) {
        print("Error loading category data: $e");
        setState(() {
          hasCategoryData = false;
          categories = [];
        });
      }
      
      // Try to get all products data for initial load
      try {
        AllProductsResponseModel allProductsResponse = await Dashbordservice.getAllProduct();
        if (allProductsResponse.success) {
          setState(() {
            allProductsData = allProductsResponse;
            allProducts = allProductsResponse.data.allProductList;
            currentProducts = allProductsResponse.data.allProductList; // Show all products by default
            hasProductData = true;
          });
        }
      } catch (e) {
        print("Error loading products data: $e");
        setState(() {
          hasProductData = false;
          allProducts = [];
          currentProducts = [];
        });
      }

    } finally {
      // Always set loaded to true, even if some APIs failed
      setState(() {
        loaded = true;
      });
    }
  }

  // Guest-specific bottom drawer with limited options
  void _showGuestBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.3,
        maxChildSize: 0.6,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Guest drawer content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Welcome message
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 40,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Welcome Guest!",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Login to access all features",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        
                        // Available features for guests - only show if data is available
                        if (hasGoldRateData)
                          _buildGuestMenuItem(
                            icon: Icons.trending_up,
                            title: "Gold Rates",
                            subtitle: "View current gold prices",
                            onTap: () {
                              Navigator.pop(context);
                              // Already visible on main screen
                            },
                          ),
                        
                        if (hasProductData)
                          _buildGuestMenuItem(
                            icon: Icons.inventory,
                            title: "Browse Products",
                            subtitle: "View our jewelry collection",
                            onTap: () {
                              Navigator.pop(context);
                              // Already visible on main screen
                            },
                          ),
                        
                        _buildGuestMenuItem(
                          icon: Icons.info_outline,
                          title: "About Us",
                          subtitle: "Learn more about our company",
                          onTap: () {
                            Navigator.pop(context);
                            _showAboutDialog();
                          },
                        ),
                        
                        SizedBox(height: 20),
                        
                        // Login button
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _navigateToLogin();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.login, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  "Login to Continue",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuestMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: Colors.grey[50],
      ),
    );
  }

  // Show login prompt when guest tries to access restricted features
  void _showLoginPrompt() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.lock,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 10),
              Text(
                'Login Required',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Please login to view product details and access exclusive features.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToLogin();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Navigate to login screen
  void _navigateToLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false
    );
  }

  // Show about dialog
  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'About Us',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ST Jewellery',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We are a premium jewelry store offering the finest collection of gold and silver ornaments. Our commitment to quality and craftsmanship has made us a trusted name in the industry.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 15),
              Text(
                'Features:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text('• Live gold rate updates'),
              Text('• Premium jewelry collection'),
              Text('• Secure online shopping'),
              Text('• Expert craftsmanship'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
