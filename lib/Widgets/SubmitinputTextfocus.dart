import 'package:flutter/material.dart';
import 'package:stjewellery/Utils/Utils.dart';

class SubmitTextInputTextfocus extends StatelessWidget {
  const SubmitTextInputTextfocus({
    Key? key,
    required this.label,
    required this.hint,
    required this.keyboard,
    required this.controller,
    required this.edit,
    required this.fcous,
  }) : super(key: key);
  final String label, hint;
  final FocusNode fcous;
  final TextInputType keyboard;
  final bool edit;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            keyboardType: keyboard,
            controller: controller,
            enabled: edit,
            focusNode: fcous,
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
