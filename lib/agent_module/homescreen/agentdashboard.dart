// import 'package:flutter/material.dart';
// import 'package:stjewellery/Constant/Constants.dart';
// import 'package:stjewellery/Utils/Utils.dart';
// import 'package:stjewellery/model/Dashboardmodel.dart' as model;
// import 'package:stjewellery/screens/Config/ApiConfig.dart';
// import 'package:stjewellery/service/Dashboardservice.dart';
//
// class AgentDashboardhome extends StatefulWidget {
//   static String routeName = "/AgentDashboardhome";
//   const AgentDashboardhome({key}) : super(key: key);
//
//   @override
//   _DashboardhomeState createState() => _DashboardhomeState();
// }
//
// class _DashboardhomeState extends State<AgentDashboardhome> {
//   List<String> imageList = [];
//   bool updown = false;
//   String? gram;
//   String ?change;
//   List<String> imageList1 = [];
//   int ?role;
//   bool loaded = false;
//   model.Dashboardmodel ?data;
//   final amountController = TextEditingController();
//   getrole() async {
//     role = await getSavedObject("roleid");
//     //number= await getSavedObject("phone");
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getUserDetails();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return loaded
//         ? Scaffold(
//             appBar: AppBar(
//               backgroundColor: themeClr,
//               centerTitle: true,
//               title: Image.asset("assets/logo.png"),
//             ),
//             //   backgroundColor: ColorUtil.fromHex("461524"),
//             bottomNavigationBar: GestureDetector(
//               onTap: () {
//                 // Navigator.of(context).pushNamed(Agentab.routeName);
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     top: 2, bottom: 5, left: 15, right: 15),
//                 child: Container(
//                   height: 50,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: themeClr, borderRadius: BorderRadius.circular(50)),
//                   child: const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       "View Customers",
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             body: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.height * 0.3 + 110,
//                     child: Stack(
//                       textDirection: TextDirection.rtl,
//                       children: <Widget>[
//                         Align(
//                           alignment: Alignment.topCenter,
//                           child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             child: InkWell(
//                               // onTap: () async {
//                               //   if (await canLaunch(
//                               //       "https://www.proaims.in/")) {
//                               //     await launch(
//                               //         "https://www.proaims.in/");
//                               //   } else {
//                               //     throw 'Could not launch "https://www.proaims.in/';
//                               //   }
//                               // },
//                               child: ClipRRect(
//                                 child: GFCarousel(
//                                   viewportFraction: 1.0,
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.3,
//                                   activeIndicator: Colors.white,
//                                   passiveIndicator: Colors.black,
//                                   hasPagination: true,
//                                   autoPlay: true,
//                                   items: imageList.map(
//                                     (item) {
//                                       return Container(
//                                         margin: const EdgeInsets.all(0.0),
//                                         child: ClipRRect(
//                                           borderRadius: const BorderRadius.all(
//                                               Radius.circular(0.0)),
//                                           child: Image.network(
//                                               ApiConfigs.imageurls + item,
//                                               fit: BoxFit.cover,
//                                               width: MediaQuery.of(context)
//                                                   .size
//                                                   .width),
//                                         ),
//                                       );
//                                     },
//                                   ).toList(),
//                                   //   onPageChanged: (index) {
//                                   //     setState(() {
//                                   //       index;
//                                   //     });
//                                   //   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.bottomCenter,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 30),
//                             child: Container(
//                               height: 130,
//                               child: Stack(
//                                 children: [
//                                   Align(
//                                       child: Container(
//                                           height: 110,
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               gradient: goldenUpDownGradient),
//                                           child: Container(
//                                             alignment: Alignment.center,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 10),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceAround,
//                                                 children: [
//                                                   Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     mainAxisSize:
//                                                         MainAxisSize.max,
//                                                     children: [
//                                                       Text("1 Gram",
//                                                           style: size14_400),
//                                                       h(5),
//                                                       Text(
//                                                           rs +
//                                                               data.data
//                                                                   .todayRate
//                                                                   .toString()
//                                                                   .split(
//                                                                       ".")[0],
//                                                           style: goldrateText)
//                                                     ],
//                                                   ),
//                                                   Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     mainAxisSize:
//                                                         MainAxisSize.max,
//                                                     children: [
//                                                       Text("8 Gram",
//                                                           style: size14_400),
//                                                       h(5),
//                                                       Text(
//                                                           rs +
//                                                               gram
//                                                                   .toString()
//                                                                   .split(
//                                                                       ".")[0],
//                                                           style: goldrateText)
//                                                     ],
//                                                   ),
//                                                   Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     mainAxisSize:
//                                                         MainAxisSize.max,
//                                                     children: [
//                                                       Text(
//                                                           updown
//                                                               ? "Up"
//                                                               : "Down",
//                                                           style: size14_400),
//                                                       h(5),
//                                                       Text(
//                                                           rs +
//                                                               change
//                                                                   .toString()
//                                                                   .split(
//                                                                       ".")[0],
//                                                           style: goldrateText)
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ))),
//                                   Align(
//                                     alignment: Alignment.topCenter,
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           color: bgClr,
//                                           borderRadius: const BorderRadius.all(
//                                               Radius.circular(5))),
//                                       child: const Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 18.0,
//                                             right: 18,
//                                             top: 4,
//                                             bottom: 4),
//                                         child: Text(
//                                           "Today's Gold Rate",
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               color: Color.fromRGBO(
//                                                   236, 236, 236, 1),
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   divBlack,
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 15, vertical: 10),
//                     child: Text(storeName, style: size14_700),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: GFCarousel(
//                       viewportFraction: 1.0,
//                       activeIndicator: Colors.white,
//                       passiveIndicator: Colors.black,
//                       hasPagination: true,
//                       autoPlay: true,
//                       items: imageList1.map(
//                         (item) {
//                           return Container(
//                             margin: const EdgeInsets.all(0.0),
//                             child: ClipRRect(
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(10.0)),
//                               child: Image.network(ApiConfigs.imageurls + item,
//                                   fit: BoxFit.cover,
//                                   width: MediaQuery.of(context).size.width),
//                             ),
//                           );
//                         },
//                       ).toList(),
//                       //   onPageChanged: (index) {
//                       //     setState(() {
//                       //       index;
//                       //     });
//                       //   },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 15, vertical: 10),
//                     child: ReadMoreText(
//                         data.data.bannerContent.bannerContent.toString(),
//                         //data.data.schemeDetails.description.toString(),
//                         style: size12_400,
//                         trimLines: 2,
//                         colorClickableText: Colors.red,
//                         trimMode: TrimMode.Line,
//                         trimCollapsedText: "...Show more",
//                         trimExpandedText: ' \nShow less',
//                         textAlign: TextAlign.left,
//                         moreStyle: font(12, Colors.black, FontWeight.w400),
//                         lessStyle:
//                             font(12, const Color(0xff000000), FontWeight.w400)),
//                   ),
//
//                   // Padding(
//                   //   padding: const EdgeInsets.only(left: 10,right: 10,top:10,bottom: 10,),
//                   //   child:   Center(
//                   //     child:   Container(
//                   //     width: MediaQuery.of(context).size.width,
//                   //       child: ClipRRect(
//                   //         borderRadius: BorderRadius.circular(10),
//                   //         child: Image.asset("assets/bangle.png",fit:BoxFit.cover ,))),
//                   //   ),
//                   // ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//
//                   Visibility(
//                     visible: false,
//                     child: InkWell(
//                       onTap: () {
//                         //   Navigator.of(context).pushNamed(Brochure.routeName);
//                       },
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 15.0, right: 15),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: ColorUtil.fromHex("00a951"),
//                                 ),
//                                 borderRadius:
//                                     const BorderRadius.all(Radius.circular(20))),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Brochure",
//                                     style: TextStyle(
//                                       color: ColorUtil.fromHex("00a951"),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   Icon(
//                                     Icons.download,
//                                     color: ColorUtil.fromHex("00a951"),
//                                     size: 14,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                 ],
//               ),
//             ))
//         : Scaffold(
//             body: Container(),
//           );
//   }
//
//   Future<model.Dashboardmodel> getUserDetails() async {
//     try {
//       EasyLoading.show(status: 'Loading...');
//       //showLoading(context);
//       model.Dashboardmodel datas = await Dashbordservice.getDashboard();
//       EasyLoading.dismiss();
//
//       if (datas.success) {
//         print(datas.message);
//         imageList = datas.data.bannerImage.map((e) => e.bannerImage).toList();
//         imageList1 = datas.data.schemeImage.map((e) => e.bannerImage).toList();
//
//         gram = (double.parse(datas.data.todayRate) * 8).toString();
//
//         if (double.parse(datas.data.todayRate) >
//             double.parse(datas.data.gramPrevious)) {
//           change = ((double.parse(datas.data.todayRate) -
//                       double.parse(datas.data.gramPrevious)) *
//                   8)
//               .toString();
//           updown = true;
//         } else {
//           change = ((double.parse(datas.data.gramPrevious) -
//                       double.parse(datas.data.todayRate)) *
//                   8)
//               .toString();
//           updown = false;
//         }
//
//         setState(() {
//           data = datas;
//           loaded = true;
//         });
//       }
//       return datas;
//     } catch (e) {
//       print(e);
//       // showErrorMessage(e);
//       EasyLoading.dismiss();
//       //  Navigator.pop(context);
//     }
//   }
// }
