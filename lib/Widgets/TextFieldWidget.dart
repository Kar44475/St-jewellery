import 'package:flutter/material.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/text_capitalization.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController edit;
  final TextInputType keyboard;

  const TextFieldWidget({
    Key? key,
    required this.label,
    required this.edit,
    required this.keyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: TextFormField(
        controller: edit,
        keyboardType: keyboard,
        inputFormatters: [UpperCaseTextFormatter()],
        decoration: InputDecoration(
          labelText: label,

          // hintStyle: font(12, Colors.black54, FontWeight.w400),
          labelStyle: font(14, Colors.black54, FontWeight.w400),
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(),
          ),
        ),
      ),
    );
  }
}

class TextFieldWidgetDef extends StatelessWidget {
  final String label;
  final TextEditingController edit;
  final TextInputType keyboard;

  const TextFieldWidgetDef({
    Key? key,
    required this.label,
    required this.edit,
    required this.keyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: TextFormField(
        controller: edit,
        keyboardType: keyboard,
        // inputFormatters: [UpperCaseTextFormatter()],
        decoration: InputDecoration(
          labelText: label,

          // hintStyle: font(12, Colors.black54, FontWeight.w400),
          labelStyle: font(14, Colors.black54, FontWeight.w400),
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(),
          ),
        ),
      ),
    );
  }
}

class Messageview extends StatelessWidget {
  const Messageview({
    Key? key,
    required TextEditingController controller,
    required String label,
    required double height,
  }) : _controller = controller,
       _label = label,
       _heigth = height,
       super(key: key);
  final String _label;
  final TextEditingController _controller;
  final double _heigth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110, // height: _heigth,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 100,
              child: TextField(
                controller: _controller,
                cursorColor: Colors.black,
                style: const TextStyle(fontSize: 15, color: Colors.black),
                minLines: 10,
                textInputAction: TextInputAction.done,
                maxLines: 15,
                autocorrect: false,
                decoration: const InputDecoration(
                  // filled: true,
                  // fillColor: Colors.white,
                  // hintText: _label,
                  hintStyle: TextStyle(color: Colors.black54),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 25,
            top: 3,
            child: Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              color: Colors.white,
              child: const Text(
                "Address",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextfliedwidgetBlack extends StatelessWidget {
  final String label;
  final TextEditingController edit;
  final TextInputType keyboard;

  const TextfliedwidgetBlack({
    Key? key,
    required this.label,
    required this.edit,
    required this.keyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        style: font(12, Colors.black, FontWeight.w500),
        keyboardType: keyboard,
        controller: edit,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          filled: false,
          labelText: label,
          labelStyle: font(12, Colors.black, FontWeight.w400),
          contentPadding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black26),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}

class CapitalTextfliedwidgetBlack extends StatelessWidget {
  final String label;
  final TextEditingController edit;
  final TextInputType keyboard;

  const CapitalTextfliedwidgetBlack({
    Key? key,
    required this.label,
    required this.edit,
    required this.keyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        style: font(12, Colors.black, FontWeight.w500),
        keyboardType: keyboard,
        controller: edit,
        inputFormatters: [UpperCaseTextFormatter()],
        cursorColor: Colors.black,
        decoration: InputDecoration(
          filled: false,
          labelText: label,
          labelStyle: font(12, Colors.black, FontWeight.w400),
          contentPadding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black26),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
