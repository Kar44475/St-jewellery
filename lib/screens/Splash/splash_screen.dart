import 'dart:io';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stjewellery/AgentModule/homescreen/agentab.dart';
import 'package:stjewellery/BottomNav/bottom_navigation.dart';
import 'package:stjewellery/Utils/Utils.dart';
import 'package:stjewellery/screens/Login_OTP/LoginScreen.dart';
import 'package:stjewellery/screens/PackagesScreen/SelectScheme.dart';
import 'package:stjewellery/screens/Update/UpdateScreen.dart';
import 'package:stjewellery/service/Dashboardservice.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() {
    Future.delayed(const Duration(seconds: 3), () {
      startTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Image.asset(
  "assets/pngIcons/mainIcons.png", 
  fit: BoxFit.contain,
  width: screenWidth * 0.7,
  height: screenWidth *0.7,
),
            ),
          ),
          Positioned(
            bottom: 50,
            left: screenWidth * 0.46,
            right: screenWidth * 0.46,
            child: const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> startTime() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final buildNumber = packageInfo.buildNumber;
      print("Build Number: $buildNumber");

      final currentBuild = int.tryParse(buildNumber) ?? 0;

      final datas = await Dashbordservice.getDashboard();
      final latestAndroidBuild = datas.data.versions.android;
      final latestIosBuild = datas.data.versions.ios;

      if (Platform.isAndroid) {
        print("going android");
        if (latestAndroidBuild > currentBuild) {
          Navigate.pushAndRemoveUntil(context, const UpdateScreen());
        } else {
          print("elseeee");
          navigationPage();
        }
      } else if (Platform.isIOS) {
        print("going ios");
        if (latestIosBuild > currentBuild) {
          Navigate.pushAndRemoveUntil(context, const UpdateScreen());
        } else {
          print("elseeee");
          navigationPage();
        }
      }
    } catch (e) {
      print("Error in startTime: $e");
      // Fallback to navigation if API fails
      navigationPage();
    }
    
    final tkkk = await getSavedObject('token');
    print("``````````````````````");
    print(tkkk);
    print("``````````````````````");
  }

  Future<void> navigationPage() async {
    try {
      final role = await getSavedObject("roleid");
      final subscription = await getSavedObject("subscription");
      print("sub :" + subscription.toString());
      print("role :" + role.toString());

      if (role != null) {
        if (role == 2 || role == 4) {
          if (subscription != null) {
            Navigate.pushAndRemoveUntil(context, BottomNav());
          } else {
            Navigate.pushAndRemoveUntil(context, SelectScheme());
          }
        } else if (role == 3) {
          Navigate.pushAndRemoveUntil(context, Agentab());
        }
      } else {
        Navigate.pushReplacement(context, const LoginScreen());
      }
    } catch (e) {
      print("Error in navigationPage: $e");
      // Fallback to login screen
      Navigate.pushReplacement(context, const LoginScreen());
    }
  }
}
