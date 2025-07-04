import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stjewellery/BottomNav/new_home_screen.dart';
import 'package:stjewellery/screens/Splash/splash_screen.dart';
import 'package:stjewellery/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ST Jewellery',
      // theme: ThemeData(
      //   appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      //   scaffoldBackgroundColor: Colors.white,
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),

      theme: stJewelleryTheme,
      home: ModernHomeScreen(),
    );
    // home: SplashScreen());
  }
}
