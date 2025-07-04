import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stjewellery/agent_module/agent_profile_view/agent_profile_view.dart';
import 'package:stjewellery/agent_module/Paymentdetails/Pendingpaymentdetials.dart';
import 'package:stjewellery/screens/main_screens/jewellery_details_home_screen.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/screens/Login_OTP/login_screen.dart';
import 'package:stjewellery/service/logoutservice.dart';

void newAgentDrawer(context) async {
  String? user = "";
  String? terms = "";
  String? refers = "";
  String? phone = "";
  String? subscriptionid = "";
  int? userid;

  var _user = await getSavedObject("name");
  var _terms = await getSavedObject("terms");
  var _refers = await getSavedObject("refers");
  var _phone = await getSavedObject("phone");
  var _userid = await getSavedObject("userid");
  var _subscriptionid = await getSavedObject("subscription");

  user = _user;
  terms = _terms;
  refers = _refers;
  phone = _phone;
  userid = _userid;
  subscriptionid = _subscriptionid.toString();

  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(Icons.person, color: Colors.white, size: 24),
                ),
                SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user ?? "Agent",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      Text(
                        phone ?? "",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 25),

          // Menu Items
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _buildMenuItem(context, Icons.person_outline, "My Profile", () {
                  Navigator.pop(context);
                  Navigate.push(context, AgentProfileView());
                }),
                SizedBox(height: 12),
                _buildMenuItem(
                  context,
                  Icons.payment_outlined,
                  "Pending Payment",
                  () {
                    Navigator.pop(context);
                    Navigate.push(context, PendingPayment());
                  },
                ),
              ],
            ),
          ),

          // SizedBox(height: 30),

          // // Logout Section
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: _buildLogoutItem(
          //     context,
          //     Icons.power_settings_new,
          //     "LOGOUT",
          //     () {
          //       Navigator.pop(context);
          //       exitApp(context);
          //     },
          //   ),
          // ),

          // Bottom padding for safe area
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildMenuItem(
  BuildContext context,
  IconData icon,
  String title,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
        ],
      ),
    ),
  );
}

Widget _buildLogoutItem(
  BuildContext context,
  IconData icon,
  String title,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.2), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.red, size: 18),
          ),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget tile(IconData icon, String txt, GestureTapCallback onTap) {
  return ListTile(
    dense: true,
    contentPadding: EdgeInsets.zero,
    title: Text(
      txt.toUpperCase(),
      style: const TextStyle(color: Colors.black, fontSize: 13),
    ),
    leading: Icon(icon, color: Colors.black),
    onTap: onTap,
  );
}

Widget divvv() {
  return const Divider(color: Colors.black54, endIndent: 40, indent: 40);
}

Future<dynamic> exitApp(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Icon(Icons.logout, color: Colors.red, size: 24),
          SizedBox(width: 10),
          Text(
            'Confirm Exit?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to logout from your account?',
        style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.4),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pop(true);
            close(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Logout',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

Future<dynamic> deleteAccount(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Icon(Icons.delete_forever, color: Colors.red, size: 24),
          SizedBox(width: 10),
          Text(
            'Delete Account?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to delete this account? This action cannot be undone.',
        style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.4),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pop(true);
            close(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Delete',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

void close(BuildContext context) async {
  try {
    Loading.show(context);
    await Logoutservice.logoutservice();

    Loading.dismiss();

    // Uncomment these lines if you need to clear SharedPreferences
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // await preferences.clear();

    // Navigate to ModernHomeScreen and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => JewelleryDetailsHomeScreen()),
      (route) => false, // This removes all previous routes
    );
  } catch (e) {
    showToast("Failed to logout try again later" + e.toString());
    Loading.dismiss();
    print(e);
  }
}
