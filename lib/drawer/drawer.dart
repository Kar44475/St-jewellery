import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stjewellery/agent_module/agent_home_screen/agent_tab.dart';

import 'package:stjewellery/drawer/contact_us.dart';

import 'package:stjewellery/drawer/privacy_policy.dart';
import 'package:stjewellery/drawer/refer_and_earn.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/Widgets/exitwidget.dart';
import 'package:stjewellery/screens/Login_OTP/login_screen.dart';
import 'package:stjewellery/screens/PackagesScreen/select_scheme.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String user = "";
  String ss = "";
  bool isLoggedIn = false;
  bool isLoading = true;
  bool isAgent = false;

  getUser() async {
    try {
      var _user = await getSavedObject("name");
      var _ss = await getSavedObject("Email");
      var token = await getSavedObject("token");
      var userId = await getSavedObject("userid");
      var referalId = await getSavedObject(
        "referalId",
      ); // Check for agent referral ID

      setState(() {
        user = _user ?? "";
        ss = _ss ?? "";
        // Check if user is logged in by checking for token or userid
        isLoggedIn =
            (token != null && token.toString().isNotEmpty) ||
            (userId != null && userId.toString().isNotEmpty);
        // Check if user is an agent by checking for referral ID
        isAgent = referalId != null && referalId.toString().isNotEmpty;
        isLoading = false;
      });
    } catch (e) {
      print("Error getting user data: $e");
      setState(() {
        user = "";
        ss = "";
        isLoggedIn = false;
        isAgent = false;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildHeaderSection(),

          SizedBox(height: 20),

          _buildMenuItems(),

          SizedBox(height: 30),

          _buildActionSection(),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
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
      child: Row(
        children: [
          // Profile Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Lottie.asset(
              'assets/profile.json',
              height: 30,
              width: 30,
              repeat: false,
            ),
          ),
          SizedBox(width: 15),
          // User Info - Different content based on login status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isLoggedIn ? (user.isNotEmpty ? user : "User") : "Guest User",
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
                  isLoggedIn
                      ? (isAgent
                            ? "Agent Account"
                            : (ss.isNotEmpty ? ss : "Welcome back!"))
                      : "Login to access all features",
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
    );
  }

  Widget _buildMenuItems() {
    List<Widget> menuItems = [];

    // Always available items
    menuItems.addAll([
      _buildMenuItem(Icons.privacy_tip_outlined, "Privacy & Terms", () {
        Navigator.pop(context);
        Navigate.push(context, PrivacyPolicy());
      }),
      _buildMenuItem(Icons.support_agent, "Help & Support", () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactUs()),
        );
      }),
    ]);

 
    if (isLoggedIn && isAgent) {
      menuItems.insert(
        0,
        _buildMenuItem(Icons.dashboard, "Agent Dashboard", () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgentTab()),
          );
        }),
      );
    }


    if (isLoggedIn && !isAgent) {
      menuItems.insertAll(0, [
        _buildMenuItem(Icons.calendar_today, "Switch Plan", () {
          Navigator.pop(context);
          Navigate.pushReplacement(context, SelectScheme());
        }),
        _buildMenuItem(Icons.person_add_alt_1_outlined, "Invite & Earn", () {
          Navigator.pop(context);
          Navigate.push(context, ReferAndEarn());
        }),
      ]);
    }

    return Wrap(spacing: 10, runSpacing: 10, children: menuItems);
  }

  Widget _buildActionSection() {
    if (isLoggedIn) {
   
      return _buildLogoutItem(Icons.power_settings_new, "Log Out", () {
        Navigator.pop(context);
        exitApp(context);
      });
    } else {
   
      return _buildLoginItem(Icons.login, "Log In", () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    }
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.of(context).size.width - 60) / 2,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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

  Widget _buildLoginItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 18,
              ),
            ),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
