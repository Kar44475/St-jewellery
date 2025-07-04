
import 'package:flutter/material.dart';
import 'package:stjewellery/screens/main_screens/jewellery_details_home_screen.dart';
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
      theme: stJewelleryTheme,
      home: JewelleryDetailsHomeScreen(),
    );

  }
}
