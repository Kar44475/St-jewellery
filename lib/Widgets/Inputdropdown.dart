import 'package:flutter/material.dart';
import 'package:stjewellery/Constant/constants.dart';

// class SubmitSelectInputBorder extends StatelessWidget {
//   const SubmitSelectInputBorder({
//     Key? key,
//     required this.label,
//     required this.hint,
//     required this.listvalues,
//     required this.onChanged,
//     required this.dropdownValue,
//   }) : super(key: key);
//
//   final String label, hint;
//   final List<String> listvalues;
//   final String? dropdownValue;
//   final ValueChanged<String?> onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
//       child: Container(
//         height: 50,
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(Radius.circular(5)),
//           border: Border.all(color: Colors.black38),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.only(
//                 left: 20.0, top: 10, bottom: 10, right: 20),
//             child: Theme(
//               data: Theme.of(context).copyWith(
//                 canvasColor: const Color.fromRGBO(254, 254, 254, 1),
//               ),
//               child: DropdownButton<String>(
//                 hint: Text(
//                   hint,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color.fromRGBO(141, 142, 141, 1),
//                   ),
//                 ),
//                 isDense: true,
//                 isExpanded: true,
//                 elevation: 1,
//                 value: dropdownValue!,
//                 underline: Container(
//                   height: 0,
//                 ),
//                 icon: const Icon(Icons.arrow_drop_down),
//                 iconSize: 24,
//                 onChanged: onChanged,
//                 items: listvalues.map((value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(
//                       value,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Color.fromRGBO(41, 42, 41, 1),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class SubmitSelectInputBorder extends StatelessWidget {
  SubmitSelectInputBorder({
    Key? key,
    required this.label,
    required this.hint,
    required this.listvalues,
    required this.onChanged,
    this.dropdownValue,
  }) : super(key: key);
  final String label, hint;
  final List<String> listvalues;
  String? dropdownValue;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.black26),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 10,
              bottom: 10,
              right: 20,
            ),
            child: DropdownButton<String>(
              hint: Text(
                hint,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              isDense: true,
              isExpanded: true,
              elevation: 2,
              dropdownColor: Colors.white,
              value: dropdownValue,
              underline: Container(height: 0),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              style: font(15, Colors.black54, FontWeight.w500),
              onChanged: (v) {
                onChanged(v);
              },
              items: listvalues.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
