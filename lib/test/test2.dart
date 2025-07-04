// import 'package:flutter/material.dart';
// import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

// void main() {
//   runApp(const testt());
// }

// class testt extends StatefulWidget {
//   const testt({Key? key}) : super(key: key);

//   @override
//   testtState createState() => testtState();
// }

// class testtState extends State<testt> {

//   late String title;

//   @override
//   void initState() {
//     title = "Home";
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(fontFamily: 'BalsamiqSans'),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: SliderDrawer(
//             appBar: SliderAppBar(
//                 appBarColor: Colors.white,
//                 title: Text(title,
//                     style: const TextStyle(
//                         fontSize: 22, fontWeight: FontWeight.w700))),
//             key: _sliderDrawerKey,
//             sliderOpenSize: 179,
//             slider: _SliderView(
//               onItemClick: (title) {
//                 _sliderDrawerKey.currentState!.closeSlider();
//                 setState(() {
//                   this.title = title;
//                 });
//               },
//             ),
//             child: Container(
//               color: Colors.blue,
//             )),
//       ),
//     );
//   }
// }

// class _SliderView extends StatelessWidget {
//   final Function(String)? onItemClick;

//   const _SliderView({Key? key, this.onItemClick}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.only(top: 30),
//       child: ListView(
//         children: <Widget>[
//           const SizedBox(
//             height: 30,
//           ),
//           CircleAvatar(
//             radius: 65,
//             backgroundColor: Colors.grey,
//             child: CircleAvatar(
//               radius: 60,
//               backgroundImage: Image.network(
//                       'https://nikhilvadoliya.github.io/assets/images/nikhil_1.webp')
//                   .image,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           const Text(
//             'Nick',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 30,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           ...[
//             Menu(Icons.home, 'Home'),
//             Menu(Icons.add_circle, 'Add Post'),
//             Menu(Icons.notifications_active, 'Notification'),
//             Menu(Icons.favorite, 'Likes'),
//             Menu(Icons.settings, 'Setting'),
//             Menu(Icons.arrow_back_ios, 'LogOut')
//           ]
//               .map((menu) => _SliderMenuItem(
//                   title: menu.title,
//                   iconData: menu.iconData,
//                   onTap: onItemClick))
//               .toList(),
//         ],
//       ),
//     );
//   }
// }

// class _SliderMenuItem extends StatelessWidget {
//   final String title;
//   final IconData iconData;
//   final Function(String)? onTap;

//   const _SliderMenuItem(
//       {Key? key,
//       required this.title,
//       required this.iconData,
//       required this.onTap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//         title: Text(title,
//             style: const TextStyle(
//                 color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
//         leading: Icon(iconData, color: Colors.black),
//         onTap: () => onTap?.call(title));
//   }
// }

// class Quotes {
//   final MaterialColor color;
//   final String author;
//   final String quote;

//   Quotes(this.color, this.author, this.quote);
// }

// class Menu {
//   final IconData iconData;
//   final String title;

//   Menu(this.iconData, this.title);
// }
