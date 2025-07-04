import 'package:flutter/material.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/model/Notificationmodel.dart';
import 'package:stjewellery/service/notificationservice.dart';
import 'package:intl/intl.dart';
import 'package:icons_plus/icons_plus.dart';

class Notificationsscreen extends StatefulWidget {
  const Notificationsscreen({Key? key}) : super(key: key);

  @override
  State<Notificationsscreen> createState() => _NotificationsscreenState();
}

class _NotificationsscreenState extends State<Notificationsscreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getnoification();
    });
    super.initState();
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
          "Notifications",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Mark all as read functionality
            },
            icon: Icon(Icons.done_all, color: Colors.white),
          ),
        ],
      ),
      body: load == true
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : data!.data.notification.isNotEmpty
              ? Column(
                  children: [
                    // Header Section
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                              Icons.notifications_active,
                              color: Colors.black87,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Recent Notifications",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  "${data!.data.notification.length} notifications",
                                  style: TextStyle(
                                    fontSize: 12,
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
                    
                    // Notifications List
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: data!.data.notification.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildNotificationCard(index);
                        },
                      ),
                    ),
                  ],
                )
              : _buildEmptyState(),
    );
  }

  Widget _buildNotificationCard(int index) {
    final notification = data!.data.notification.elementAt(index);
    
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.notifications,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
            
            SizedBox(width: 12),
            
            // Notification Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Time Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _formatDate(notification.createdAt.toString()),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 8),
                  
                  // Description
                  Text(
                    notification.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                  
                  SizedBox(height: 12),
                  
                  // Bottom Row with Date and Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: Colors.grey[500],
                          ),
                          SizedBox(width: 4),
                          Text(
                            DateFormat('dd MMM, yyyy').format(
                              DateTime.parse(notification.createdAt.toString()),
                            ),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      
                      // Unread indicator (you can add logic to show/hide based on read status)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.notifications_off,
              size: 50,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 20),
          Text(
            "No Notifications",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "You're all caught up!\nWe'll notify you when something new arrives.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      DateTime now = DateTime.now();
      Duration difference = now.difference(date);
      
      if (difference.inDays == 0) {
        if (difference.inHours == 0) {
          return "${difference.inMinutes}m ago";
        }
        return "${difference.inHours}h ago";
      } else if (difference.inDays == 1) {
        return "Yesterday";
      } else if (difference.inDays < 7) {
        return "${difference.inDays}d ago";
      } else {
        return DateFormat('dd MMM').format(date);
      }
    } catch (e) {
      return "Now";
    }
  }

  bool load = true;
  NotificationModel? data;
  
  Future<void> getnoification() async {
    try {
      Loading.show(context);
      NotificationModel datas = await Notificationservice.notification();
      Loading.dismiss();
      setState(() {
        data = datas;
        load = false;
      });
    } catch (e) {
      print(e);
      Loading.dismiss();
      setState(() {
        load = false;
      });
    }
  }
}
