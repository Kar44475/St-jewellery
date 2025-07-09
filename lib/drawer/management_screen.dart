import 'package:flutter/material.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stjewellery/model/teamModel.dart';
import 'package:stjewellery/service/teamservice.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  TeamModel? data;
  bool load = true;
  
  getPaymentdetails() async {
    TeamModel datas;
    int userid;
    try {
      Loading.show(context);
      datas = await Teamservice.getTeam();
      setState(() {
        data = datas;
        load = false;
      });
      print(data!.data!.status.toString());
      Loading.dismiss();
      return datas;
    } catch (e) {
      Loading.dismiss();
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getPaymentdetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "Management Team",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: load == true
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : data!.data!.bankDetails!.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "No Management Data",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Management information will appear here",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 203, 3, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.people,
                                color: Colors.black87,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Our Management Team",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${data!.data!.bankDetails!.length} Members",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      
                      // Team Members List
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data!.data!.bankDetails!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final member = data!.data!.bankDetails!.elementAt(index);
                          return Container(
                            margin: EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  // Profile Section
                                  Row(
                                    children: [
                                      // Avatar
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(
                                            color: Theme.of(context).primaryColor.withOpacity(0.2),
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          size: 30,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      
                                      // Info Section
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              member.name ?? "N/A",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(255, 203, 3, 0.2),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                member.designation ?? "N/A",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  size: 16,
                                                  color: Colors.grey[600],
                                                ),
                                                SizedBox(width: 6),
                                                Text(
                                                  member.phone ?? "N/A",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[700],
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(height: 20),
                                  
                                  // Action Buttons
                                  Row(
                                    children: [
                                      // WhatsApp Button
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            final link = WhatsAppUnilink(
                                              phoneNumber: member.phone.toString(),
                                            );
                                            await launch('$link');
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 12),
                                            decoration: BoxDecoration(
                                              color: Color(0xFF25D366).withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Color(0xFF25D366).withOpacity(0.3),
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Brand(Brands.whatsapp, size: 20),
                                                SizedBox(width: 8),
                                                Text(
                                                  "WhatsApp",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xFF25D366),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      
                                      SizedBox(width: 12),
                                      
                                      // Call Button
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            _makePhoneCall('tel:${member.phone}');
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 12),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Theme.of(context).primaryColor.withOpacity(0.3),
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  size: 20,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "Call",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context).primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
