import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Drawer_Pages/drawer.dart';
import 'package:stjewellery/ECommerceModule/Data/ProductsData.dart';
import 'package:stjewellery/ECommerceModule/ProductDetailsPage.dart';
import 'package:stjewellery/Utils/Utils.dart';
import 'package:stjewellery/Utils/starRating.dart';
import 'package:stjewellery/model/offerModel.dart';
import 'package:stjewellery/model/categorymodel.dart';
import 'package:stjewellery/model/allproductmodel.dart';
import 'package:stjewellery/model/CategoryWiseProductResponseModel.dart'; // Add this import
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:stjewellery/screens/Notification/NotificationsScreen.dart';
import 'package:stjewellery/service/Dashboardservice.dart';
import 'package:stjewellery/service/offerservice.dart';

import '../model/Dashboardmodel.dart' as model;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  List<CategoryWiseProduct> categoryProducts = []; // Add this for category-wise products
  
  // Combined list for display - can contain both AllProduct and CategoryWiseProduct
  List<dynamic> currentProducts = [];
  bool isLoadingProducts = false; // Add loading state for products

  bool loaded = false;

  double width = 0;
  bool myAnimation = false;
  String? today;
  final List<String> images = [
    'https://as2.ftcdn.net/v2/jpg/05/27/71/81/1000_F_527718147_x7XDK929xZnZqjgh0oPYz7xK0EvtnlIF.jpg',
    'https://as2.ftcdn.net/v2/jpg/02/92/56/91/1000_F_292569116_Phht4uRj1YIuLFgBhrLu8171npBOcJcr.jpg',
    'https://as1.ftcdn.net/v2/jpg/09/41/50/26/1000_F_941502630_AzU6ha5cgbscNzKnYWVCHQg5uVMT09M0.jpg',
  ];

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

  // final GlobalKey<SliderDrawerState> _sliderDrawerKey =
  //     GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    var ss = MediaQuery.of(context).size;

    return Scaffold(  
      body: !loaded
          ? const Opacity(opacity: 0)
          : Scaffold(
              appBar: AppBar(
         backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,     
                title: Image.asset(
                  "assets/pngIcons/mainIcons.png",
                  height: 55,
                ),
leading:
    IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _showBottomDrawer(context);
          },
        )
   ,
 

    actions: [
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Notificationsscreen(),
            ),
          );
        },
        icon: const Icon(Icons.notifications, size: 25, color: Colors.white),
      ),
    ],

              ),
            //  key: _sliderDrawerKey,
            
              
           
              body: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hero Image Section (30% of screen)
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
                
                      // Gold Rate Section
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
                                          today!,
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
                                    "₹${gram.toString().split(".")[0]}",
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
                                      change.toString().split(".")[0],
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
                
                      // Two Images Section
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
                        ],
                      ),
                
                      SizedBox(height: 20),
                
                   
                      // Category Tabs Section - Updated with API data
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: SizedBox(
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

                

                      // Products Section - Show loading or products
                

// In the Products Section GridView.builder, update the LayoutBuilder section:

// Products Section - Show loading or products
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
          final imgHeight = itemWidth * 0.65; // Reduced from 1.0 to 0.65 for more rectangular shape
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
                  //Navigate to product details
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         ProductDetailsEcom(data: product),
                  //   ),
                  // );
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
                              width: double.infinity, // Ensure full width
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
                              // h(5),
                              // const Row(
                              //   children: [],
                              // ),
                              // h(3),
                              // StarRating(),
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

  // Updated method to build category tabs with API data
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
          showErrorMessage(e);
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

  // Method to load all products
  Future<void> _loadAllProducts() async {
    try {
      AllProductsResponseModel allProductsResponse = await Dashbordservice.getAllProduct();
      
      if (allProductsResponse.success) {
        setState(() {
          allProducts = allProductsResponse.data.allProductList;
          currentProducts = allProducts;
        });
      }
    } catch (e) {
      print("Error loading all products: $e");
      throw e;
    }
  }

  // Method to load category-wise products
  Future<void> _loadCategoryProducts(String categoryId) async {
    try {
      CategoryWiseProductResponseModel categoryProductsResponse = 
          await Dashbordservice.getByCategoryProduct(categoryId);
      
      if (categoryProductsResponse.success) {
        setState(() {
          categoryProducts = categoryProductsResponse.data.productList;
          currentProducts = categoryProducts;
        });
      }
    } catch (e) {
      print("Error loading category products: $e");
      throw e;
    }
  }

  Offermodel? reterive;

  getOffers() async {
    {
      try {
        print("try");

        Loading.show(context);
        Offermodel reteriveData = await Offerservice.getOffers();
        print(reteriveData);
        setState(() {
          reterive = reteriveData;
        });
        Loading.dismiss();
      } catch (e) {
        print("catchhh");
        showErrorMessage(e);
        Loading.dismiss();
      }
    }
  }

  // Updated method to get user details, category and initial all products data
  Future<void> getUserDetails() async {
    await getOffers();
    var token = await getSavedObject('token');
    print(token);

    today = DateFormat('dd  MMM, yyyy').format(DateTime.now());

    try {
      Loading.show(context);
      
      // Get dashboard data
      model.Dashboardmodel? datas = await Dashbordservice.getDashboard();
      
      // Get category data
      CategoryProductResponseModel categoryData = await Dashbordservice.getDashboardCatgory();
      
      // Get all products data for initial load
      AllProductsResponseModel allProductsResponse = await Dashbordservice.getAllProduct();
      
      Loading.dismiss();

      if (datas.success && categoryData.success && allProductsResponse.success) {
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
          categoryProductData = categoryData;
          allProductsData = allProductsResponse;
          categories = categoryData.data.categoryList;
          allProducts = allProductsResponse.data.allProductList;
          currentProducts = allProductsResponse.data.allProductList; // Show all products by default
          loaded = true;
        });
      }
    } catch (e) {
      print(e);
      Loading.dismiss();
    }
  }

  categoryCircle(name, img, tapp) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: tapp,
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset("assets/categoryCircle.png", width: 80),
                Positioned(
                  left: 4,
                  right: 4,
                  top: 4,
                  bottom: 4,
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(img, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
            h(4),
            SizedBox(
              width: 80,
              child: Text(
                name.toUpperCase(),
                style: font(13, Colors.black, FontWeight.w600),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showBottomDrawer(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
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
            // Drawer content
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: DrawerWidget(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}
