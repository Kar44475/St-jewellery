import 'package:flutter/material.dart';

import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/drawer/drawer.dart';
import 'package:stjewellery/Utils/utils.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Scaffold(
        appBar: AppBar(
          // appBarHeight: 100,
          // trailing: IconButton(
          //   onPressed: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(builder: (context) => const testt()),
          //     // );
          //   },
          // icon: const Icon(Icons.notifications, size: 25),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              _showBottomDrawer(context);
            },
          ),
          // : null,
          title: Image.asset("assets/pngIcons/mainIcons.png", height: 55),
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const Notificationsscreen(),
                //   ),
                // );
              },
              icon: const Icon(
                Icons.notifications,
                size: 25,
                color: Colors.white,
              ),
            ),
          ],
        ),
        //   appBarColor: Colors.white,
        //   title: Image.asset("assets/pngIcons/mainIcons.png", scale: 5),
        // ),
        // key: _sliderDrawerKey,
        // sliderOpenSize: 200,
        // isDraggable: true,
        // slider: const DrawerWidget(
        //   // onItemClick: (v) {
        //   //   _sliderDrawerKey.currentState!.closeSlider();
        //   //   setState(() {
        //   //     // this.title = title;
        //   //   });
        //   // },
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/walletCard.png",
                      fit: BoxFit.fitHeight,
                      height: 180,
                    ),
                    Positioned(
                      top: 30,
                      left: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Wallet Balance",
                            style: font(14, Colors.white, FontWeight.w400),
                          ),
                          Text(
                            rs + "44000",
                            style: font(32, Colors.white, FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "John Doe",
                            style: font(
                              16,
                              ColorUtil.fromHex("#FFE95B"),
                              FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Text(
                "History",
                style: font(16, Colors.black, FontWeight.w600),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) =>
                      const Divider(color: Colors.black12),
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              rs + "10000",
                              style: font(17, Colors.black, FontWeight.bold),
                            ),
                            Text(
                              "Redeemed By GOLD",
                              style: font(14, Colors.black, FontWeight.w400),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          "Paid On : 02-11-2025",
                          style: font(13, Colors.black54, FontWeight.w400),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
