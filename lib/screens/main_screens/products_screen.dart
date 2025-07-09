// import 'package:flutter/material.dart';

// import 'package:stjewellery/Constant/constants.dart';
// import 'package:stjewellery/Drawer_Pages/drawer.dart';
// import 'package:stjewellery/ECommerceModule/Data/ProductsData.dart';
// import 'package:stjewellery/ECommerceModule/ProductDetailsPage.dart';
// import 'package:stjewellery/Utils/utils.dart';
// import 'package:stjewellery/Utils/starRating.dart';
// import 'package:stjewellery/screens/Notification/NotificationsScreen.dart';

// class Product {
//   final String name;
//   final String description;
//   final double originalPrice;
//   final double discountedPrice;
//   final double discountPercent;
//   final String imageUrl;

//   Product({
//     required this.name,
//     required this.description,
//     required this.originalPrice,
//     required this.discountedPrice,
//     required this.discountPercent,
//     required this.imageUrl,
//   });
// }

// class ProductsScreen extends StatefulWidget {
//   const ProductsScreen({Key? key}) : super(key: key);

//   @override
//   State<ProductsScreen> createState() => _ProductsScreenState();
// }

// class _ProductsScreenState extends State<ProductsScreen> {
//   final List<ProductsModel> Chain = getProducts();
//   // final GlobalKey<SliderDrawerState> _sliderDrawerKey =
//   //     GlobalKey<SliderDrawerState>();

//   int? role;

//   getrole() async {
//     int? fetchedRole = await getSavedObject("roleid");
//     setState(() {
//       role = fetchedRole;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getrole();
//   }

// void _showBottomDrawer(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) => DraggableScrollableSheet(
//       initialChildSize: 0.7,
//       minChildSize: 0.5,
//       maxChildSize: 0.9,
//       builder: (context, scrollController) => Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: Offset(0, -5),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [

//             Container(
//               margin: EdgeInsets.symmetric(vertical: 10),
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),

//             Expanded(
//               child: SingleChildScrollView(
//                 controller: scrollController,
//                 child: DrawerWidget(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       body: Scaffold(
//         appBar: AppBar(
//             elevation: 0,
//               backgroundColor: Theme.of(context).primaryColor,
//      title: Image.asset(
//             "assets/pngIcons/mainIcons.png",
//             height: 55,
//           ),

//   leading: role == 2 || role == 4
//       ? IconButton(
//           icon: Icon(Icons.menu, color: Colors.white),
//           onPressed: () {
//             _showBottomDrawer(context);
//           },
//         )
//       : null,
//    actions: [
//       IconButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const Notificationsscreen(),
//             ),
//           );
//         },
//         icon: const Icon(Icons.notifications, size: 25, color: Colors.white),
//       ),
//     ]

//           // appBarHeight: 100,
//           // drawerIconSize: role == 2 || role == 4 ? 20 : 0,
//           // drawerIconColor: Colors.white,
//           // trailing: IconButton(
//           //   color: Colors.white,
//           //   onPressed: () {
//           //     Navigator.push(
//           //       context,
//           //       MaterialPageRoute(
//           //         builder: (context) => const Notificationsscreen(),
//           //       ),
//           //     );
//           //   },
//           //   icon: const Icon(Icons.notifications, size: 25, color: Colors.white),
//           // ),
//           // appBarColor: Theme.of(context).primaryColor,

//         ),
//         //    key: _sliderDrawerKey,
//         //    sliderOpenSize: 200,
//         // isDraggable: role == 2 || role == 4 ? true : false,
//         // slider: role == 2 || role == 4
//         //     ? const DrawerWidget()
//         //     : const Opacity(opacity: 0),

//         body: Container(
//           color: Colors.white,
//           child: Column(
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: LayoutBuilder(
//                     builder: (context, constraints) {

//                       final availableWidth = constraints.maxWidth - 16;
//                       final itemWidth = (availableWidth - 8) / 2;
//                       final itemHeight = itemWidth * 1.3;
//                       final imgHeight = itemWidth * 0.75;
//                       final aspectRatio = itemWidth / itemHeight;

//                       return GridView.builder(
//                         shrinkWrap: true,
//                         padding: EdgeInsets.only(
//                           top: 8,
//                           bottom: 100,
//                         ),
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 8.0,
//                           mainAxisSpacing: 8.0,
//                           childAspectRatio: aspectRatio,
//                         ),
//                         itemCount: Chain.length,
//                         itemBuilder: (context, index) {
//                           final product = Chain[index];
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       ProductDetailsEcom(data: Chain[index]),
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(12),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.1),
//                                     spreadRadius: 1,
//                                     blurRadius: 5,
//                                     offset: Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [

//                                   Expanded(
//                                     flex: 3,
//                                     child: Container(
//                                       width: double.infinity,
//                                       decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           image: AssetImage(product.image),
//                                           fit: BoxFit.cover,
//                                         ),
//                                         borderRadius: const BorderRadius.only(
//                                           topLeft: Radius.circular(12),
//                                           topRight: Radius.circular(12),
//                                         ),
//                                       ),
//                                     ),
//                                   ),

//                                   Expanded(
//                                     flex: 2,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                         children: [

//                                           Flexible(
//                                             child: Text(
//                                               product.name,
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.w600,
//                                               ),
//                                             ),
//                                           ),

//                                           Flexible(
//                                             child: Text(
//                                               product.description,
//                                               maxLines: 2,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TextStyle(
//                                                 fontSize: 10,
//                                                 color: const Color(0xff787272),
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                             ),
//                                           ),

//                                           StarRating(),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ProductCard extends StatelessWidget {
//   final Product product;

//   const ProductCard({Key? key, required this.product}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         border: Border(
//           right: BorderSide(color: Colors.black12),
//           bottom: BorderSide(color: Colors.black12),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.network(
//                   product.imageUrl,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 ),
//               ),
//             ),
//             h(8),
//             Text(
//               product.name,
//               style: font(15, Colors.black, FontWeight.w600),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             h(4),
//             Text(
//               product.description,
//               style: font(13, Colors.black54, FontWeight.w500),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             h(8),
//             Text(
//               "₹${product.originalPrice.toStringAsFixed(0)}",
//               style: font(16, Colors.black, FontWeight.w600),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// }
