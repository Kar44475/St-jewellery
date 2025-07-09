import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/utils/utils.dart';
import 'package:stjewellery/Widgets/AgentNewBottomDrawer.dart';
import 'package:stjewellery/agent_module/agent_home_screen/agent_home_screen.dart';

import 'package:stjewellery/screens/main_screens/jewellery_details_home_screen.dart'; // Add this import

class AgentTab extends StatefulWidget {
  @override
  _AgentTabState createState() => _AgentTabState();
}

class _AgentTabState extends State<AgentTab> {
  String agentid = "";
  getAgent() async {
    String s = await getSavedObject("referalId");
    if (s != null)
      setState(() {
        agentid = s;
      });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getAgent();
    });
  }

  void _handleBackNavigation() {
    JewelleryDetailsHomeScreenState.selectedTabIndex = 3;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const JewelleryDetailsHomeScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          _handleBackNavigation();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        _handleBackNavigation();
                      },
                    ),

                    Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: ColorUtil.fromHex("#000000"),
                        ),
                        onPressed: () {
                          newAgentDrawer(context);
                        },
                      ),
                    ),

                    const Spacer(),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Reference ID",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                          Text(
                            agentid,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.black),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: agentid));
                        showToast("References copied");
                      },
                    ),

                    // Container(
                    //   decoration: BoxDecoration(
                    //       shape: BoxShape.circle, color: Colors.black),
                    //   child: IconButton(
                    //       icon: Icon(
                    //         Icons.power_settings_new_outlined,
                    //         color: ColorUtil.fromHex("#FFD98D"),
                    //         size: 20,
                    //       ),
                    //       onPressed: () {
                    //         exitApp(context);
                    //       }),
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 1,
                  child: Column(
                    children: [
                      Visibility(
                        visible: false,
                        child: Container(
                          height: 45,
                          color: ColorUtil.fromHex("#FFE284"),
                          child: TabBar(
                            labelColor: Colors.black,
                            unselectedLabelStyle: font(
                              12,
                              Colors.black,
                              FontWeight.w400,
                            ),
                            labelStyle: font(12, Colors.black, FontWeight.w600),
                            unselectedLabelColor: Colors.black,
                            indicatorColor: ColorUtil.fromHex("#461524"),
                            tabs: const [
                              Text(
                                "All Customers",
                                style: TextStyle(color: Colors.black),
                              ),
                              // Text(
                              //   "Next Payment",
                              //   style: TextStyle(color: Colors.black),
                              // )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _controller,
                          children: [AgentHomeScreen()],
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
    );
  }
}
