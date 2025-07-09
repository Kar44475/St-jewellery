import 'package:flutter/material.dart';
import 'package:stjewellery/support_widget/essential.dart';

class SubmitTextInput extends StatelessWidget {
  const SubmitTextInput({
    Key? key,
    required this.label,
    required this.hint,
    required this.keyboard,
    required this.controller,
    required this.edit,
    required this.textcolor,
  }) : super(key: key);
  final String label, hint;
  final Color textcolor;
  final TextInputType keyboard;
  final bool edit;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var inputPadding = const EdgeInsets.fromLTRB(2.0, 0, 0.0, 7.0);
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            keyboardType: keyboard,
            controller: controller,
            enabled: edit,
            style: TextStyle(fontSize: 14, color: ColorUtil.fromHex("#262626")),
            decoration: InputDecoration(
              //fillColor: ColorUtil.fromHex("#3C425E"),
              hintText: label,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(141, 142, 141, 1),
              ),
              contentPadding: const EdgeInsets.only(
                left: 20,
                top: 15,
                bottom: 15,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(173, 172, 171, 1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(173, 172, 171, 1),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(173, 172, 171, 1),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(173, 172, 171, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class SubmitTextInputNew extends StatelessWidget {
//   const SubmitTextInputNew(
//       {Key key,
//       @required this.label,
//       @required this.hint,
//       @required this.keyboard,
//       this.controller,
//       this.edit,
//       @required @required this.textcolor})
//       : super(key: key);
//   final String label, hint;
//   final Color textcolor;
//   final TextInputType keyboard;
//   final bool edit;
//   final TextEditingController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     var inputPadding = const EdgeInsets.fromLTRB(10.0, 0, 0.0, 7.0);
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 20.0),
//         child: TextFormField(
//           keyboardType: keyboard,
//           controller: controller,
//           cursorColor: Colors.black,
//           enabled: edit,
//           style: TextStyle(
//               fontWeight: FontWeight.w500, color: textcolor, fontSize: 13),
//           decoration: InputDecoration(
//             contentPadding: inputPadding,
//             isDense: false,
//             disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: Colors.black12)),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: const BorderSide(color: Colors.black26)),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: accentClr)),
//             hintText: hint,
//             labelText: label,
//             hintStyle: const TextStyle(color: Colors.black54),
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             labelStyle: const TextStyle(color: Colors.black54, fontSize: 14),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class newTxtfield extends StatelessWidget {
//   const newTxtfield(
//       {Key key,
//       this.Iconn,
//       this.hint,
//       @required this.keyboard,
//       this.controller,
//       this.edit,
//       @required @required this.textcolor})
//       : super(key: key);
//   final Color textcolor;
//   final IconData Iconn;
//   final TextInputType keyboard;
//   final bool edit;
//   final String hint;
//   final TextEditingController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 5),
//       child: TextFormField(
//         controller: controller,
//         enabled: edit,
//         cursorColor: Colors.black,
//         style: TextStyle(
//             fontWeight: FontWeight.w500,
//             color: edit ? Colors.black : Colors.black54,
//             fontSize: 13),
//         decoration: InputDecoration(
//           hintText: hint,
//           prefixIcon: Icon(Iconn,
//               size: 18, color: edit ? Colors.black : Colors.black54),
//           isDense: false,
//           disabledBorder: InputBorder.none,
//           enabledBorder: InputBorder.none,
//           focusedBorder: InputBorder.none,
//           border: InputBorder.none,
//           errorBorder: InputBorder.none,
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           labelStyle: const TextStyle(color: Colors.black54, fontSize: 14),
//         ),
//       ),
//     );
//   }
// }
