import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stjewellery/agent_module/agent_registration/agent_registration_screen.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/model/agent_list_model.dart';
import 'package:stjewellery/screens/PackagesScreen/select_scheme.dart';
import 'package:stjewellery/service/customer_list_service.dart';
import 'package:url_launcher/url_launcher.dart';

class AgentHomeScreen extends StatefulWidget {
  @override
  _AgentHomeScreenState createState() => _AgentHomeScreenState();
}

class _AgentHomeScreenState extends State<AgentHomeScreen> {
  int? subid;
  List<int> subidlist = [];
  StreamController<List<CustomerList>>? _dataStream;
  Stream? broadcastStream;
  List<CustomerList>? customerListall;
  List<CustomerList> customerListsearch = [];
  String? id;
  TextEditingController controllers = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getCustomerlist();
    });
    _dataStream = StreamController<List<CustomerList>>();
    broadcastStream = _dataStream!.stream.asBroadcastStream();
  }

  @override
  void dispose() {
    _dataStream?.close();
    controllers.dispose();
    super.dispose();
  }

  search(String text) {
    print(text);
    if (text.isEmpty) {
      _dataStream!.add(customerListall!);
    } else {
      customerListsearch.clear();
      customerListall!.forEach((element) {
        if (element.name!.toLowerCase().contains(text.toLowerCase()) ||
            element.registrationNumber!.toLowerCase().contains(
              text.toLowerCase(),
            ) ||
            element.phone.toString().contains(text.toString())) {
          print(customerListsearch.length.toString());
          customerListsearch.add(element);
        }
      });
      _dataStream!.add(customerListsearch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/pngIcons/mainIcons.png",
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ST JEWELLERY",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Text(
                                "Agent Dashboard",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Spacer(),

                    Text(
                      "Manage Your Customers",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "View and manage all your registered customers",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 25, 20, 15),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: controllers,
                    onChanged: search,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search customers...',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[500],
                        size: 20,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: StreamBuilder(
                stream: broadcastStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: snapshot.data != null
                          ? SafeArea(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: snapshot.data.length == 0
                                        ? Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(40),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                    child: Icon(
                                                      Icons.people_outline,
                                                      size: 40,
                                                      color: Colors.grey[500],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  Text(
                                                    "No Customers Found",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.grey[700],
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    "Start by adding your first customer",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[500],
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : ListView.builder(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 10,
                                            ),
                                            physics: BouncingScrollPhysics(),
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (BuildContext ctxt, int index) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                  bottom: 15,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.1),
                                                      spreadRadius: 1,
                                                      blurRadius: 8,
                                                      offset: Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          15,
                                                        ),
                                                    onTap: () async {
                                                      await saveObject(
                                                        "customerid",
                                                        snapshot.data
                                                            .elementAt(index)
                                                            .userId,
                                                      );
                                                      Navigate.push(
                                                        context,
                                                        SelectScheme(),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                        20,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .primaryColor
                                                                      .withOpacity(
                                                                        0.1,
                                                                      ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    12,
                                                                  ),
                                                            ),
                                                            child: Icon(
                                                              Icons.person,
                                                              color: Theme.of(
                                                                context,
                                                              ).primaryColor,
                                                              size: 24,
                                                            ),
                                                          ),

                                                          SizedBox(width: 15),

                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  snapshot.data
                                                                      .elementAt(
                                                                        index,
                                                                      )
                                                                      .name
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black87,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 4,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .badge_outlined,
                                                                      size: 14,
                                                                      color: Colors
                                                                          .grey[600],
                                                                    ),
                                                                    SizedBox(
                                                                      width: 6,
                                                                    ),
                                                                    Expanded(
                                                                      child: Text(
                                                                        snapshot
                                                                            .data
                                                                            .elementAt(
                                                                              index,
                                                                            )
                                                                            .registrationNumber
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Colors.grey[600],
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 2,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .phone_outlined,
                                                                      size: 14,
                                                                      color: Colors
                                                                          .grey[600],
                                                                    ),
                                                                    SizedBox(
                                                                      width: 6,
                                                                    ),
                                                                    Expanded(
                                                                      child: Text(
                                                                        snapshot
                                                                            .data
                                                                            .elementAt(
                                                                              index,
                                                                            )
                                                                            .phone
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Colors.grey[600],
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                              color: Colors
                                                                  .green
                                                                  .withOpacity(
                                                                    0.1,
                                                                  ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    10,
                                                                  ),
                                                            ),
                                                            child: IconButton(
                                                              onPressed: () {
                                                                openDialer(
                                                                  snapshot.data
                                                                      .elementAt(
                                                                        index,
                                                                      )
                                                                      .phone
                                                                      .toString(),
                                                                );
                                                              },
                                                              icon: Icon(
                                                                Icons.phone,
                                                                color: Colors
                                                                    .green,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [SizedBox(height: 5)],
                                  ),
                                ],
                              ),
                            )
                          : Container(decoration: const BoxDecoration()),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigate.pushWithCallback(
            context,
            AgentRegistrationScreen(),
            getCustomerlist,
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: Icon(Icons.person_add, size: 20),
        label: Text(
          "New Customer",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
    );
  }

  Future<void> getCustomerlist() async {
    Agentcustomermodel datas;
    List<CustomerList> customerList;
    String buildNumber = "11";
    try {
      Loading.show(context);
      datas = await Customerlistservice.getCustomerlist();
      customerList = datas.data!.customerList!;
      customerListall = datas.data!.customerList!;
      Loading.dismiss();

      PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
        buildNumber = packageInfo.buildNumber;
        print(buildNumber);

        if (Platform.isAndroid) {
          if (datas.data!.versions!.android! > int.parse(buildNumber)) {
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //     '/Update', (Route<dynamic> route) => false);
          }
        } else if (Platform.isIOS) {
          if (datas.data!.versions!.ios! > int.parse(buildNumber)) {
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //     '/Update', (Route<dynamic> route) => false);
          }
        }
      });

      _dataStream!.add(customerList);
    } catch (e) {
      Loading.dismiss();
      String number = await getSavedObject("phone");
      String token = await getSavedObject("token");
      print(number);
      print(token);
    }
  }

  line(String txt, IconData icn, FontWeight weight) {
    return Row(
      children: [
        Icon(icn, size: 18),
        w(10),
        Text(txt, style: TextStyle(fontSize: 14, fontWeight: weight)),
      ],
    );
  }

  void openDialer(String phoneNumber) async {
    final Uri dialUri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(dialUri)) {
      await launchUrl(dialUri);
    } else {
      throw 'Could not open dialer';
    }
  }
}
