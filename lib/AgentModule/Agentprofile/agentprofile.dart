import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stjewellery/Utils/Utils.dart';
import 'package:stjewellery/Widgets/SubmitinputText.dart';
import 'package:stjewellery/Widgets/SubmitinputTextfocus.dart';
import 'package:stjewellery/model/agentprofileviewmodel.dart';
import 'package:stjewellery/model/profileeditpostmodel.dart';
import 'package:stjewellery/service/profileeditservice.dart';

class Agentprofile extends StatefulWidget {
  @override
  _AgentprofileState createState() => _AgentprofileState();
}

class _AgentprofileState extends State<Agentprofile> {
  DateTime selectedDate = DateTime.now();
  FocusNode focus = FocusNode();

  Agentprofileviewmodel? data;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pancardController = TextEditingController();
  TextEditingController adharController = TextEditingController();
  TextEditingController addressController = TextEditingController();
//Test
  bool edit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getProfileDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(),
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Text("Profile"),
                    const Spacer(),

                    // Container(
                    //   decoration: BoxDecoration(
                    //       shape: BoxShape.circle, color: Colors.black),
                    //   child: IconButton(
                    //       icon: Icon(Icons.notifications,
                    //           color: ColorUtil.fromHex("#FFD98D")),
                    //       onPressed: null),
                    // )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 0),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10,
                            bottom: 0,
                            top: 10,
                          ),
                          child: SubmitTextInputTextfocus(
                            controller: nameController,
                            edit: edit,
                            fcous: focus,
                            label: "First Name",
                            keyboard: TextInputType.name,
                            hint: "",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10,
                            bottom: 0,
                            top: 10,
                          ),
                          child: SubmitTextInput(
                            textcolor: ColorUtil.fromHex("#000000"),
                            controller: emailController,
                            edit: false,
                            label: "Email",
                            keyboard: TextInputType.emailAddress,
                            hint: "",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 15,
                            bottom: 0,
                          ),
                          child: SubmitTextInput(
                            textcolor: ColorUtil.fromHex("#000000"),
                            controller: phoneController,
                            label: "Phone",
                            edit: false,
                            keyboard: TextInputType.phone,
                            hint: "",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 15,
                            bottom: 5,
                          ),
                          child: SubmitTextInput(
                            textcolor: ColorUtil.fromHex("#000000"),
                            controller: adharController,
                            label: "Aadhaar",
                            edit: edit,
                            keyboard: TextInputType.phone,
                            hint: "",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 15,
                            bottom: 5,
                          ),
                          child: SubmitTextInput(
                            textcolor: ColorUtil.fromHex("#000000"),
                            controller: pancardController,
                            label: "Pan Card",
                            edit: edit,
                            keyboard: TextInputType.text,
                            hint: "",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 15,
                            bottom: 5,
                          ),
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                                bottom: 10,
                                left: 10,
                                right: 10,
                              ),
                              child: TextField(
                                controller: addressController,
                                enabled: edit,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ColorUtil.fromHex("#262626"),
                                ),
                                minLines: 10,
                                textInputAction: TextInputAction.done,
                                maxLines: 15,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  // filled: true,
                                  fillColor: ColorUtil.fromHex("#ffffff"),
                                  hintText: "Address",
                                  hintStyle: TextStyle(
                                    color: ColorUtil.fromHex("#262626"),
                                  ),
                                  // enabledBorder: OutlineInputBorder(
                                  //   borderRadius: const BorderRadius.all(
                                  //       Radius.circular(10.0)),
                                  //   borderSide: BorderSide(
                                  //     color: ColorUtil.fromHex("#E3E3E3"),
                                  //   ),
                                  // ),
                                  // focusedBorder: OutlineInputBorder(
                                  //   borderRadius: const BorderRadius.all(
                                  //       Radius.circular(10.0)),
                                  //   borderSide: BorderSide(
                                  //     color: ColorUtil.fromHex("#E3E3E3"),
                                  //   ),
                                  // ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: bttn2(edit ? "Save" : "Edit", () {
                              if (!edit) {
                                setState(() {
                                  edit = true;
                                });
                                Timer(const Duration(seconds: 1), () {
                                  FocusScope.of(context).requestFocus(focus);
                                });
                              } else {
                                if (nameController.text.toString().compareTo(
                                      "",
                                    ) ==
                                    0) {
                                  showToast("Please enter name");
                                } else if (adharController.text
                                            .toString()
                                            .compareTo("") ==
                                        0 &&
                                    pancardController.text.toString().compareTo(
                                          "",
                                        ) ==
                                        0) {
                                  showToast(
                                    "Please enter Pancard or Aadhaar card details",
                                  );
                                } else {
                                  // 'UserId': ' 3',
                                  Map b = {
                                    "agentName": nameController.text.toString(),
                                    "email": emailController.text.toString(),
                                    "phone": data!.data!.userId!.phone,
                                    "pancard": pancardController.text
                                        .toString(),
                                    "adhaar": adharController.text.toString(),
                                    "address": addressController.text
                                        .toString(),
                                  };

                                  postedit(b);
                                }
                              }
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getProfileDetails() async {
    try {
      print("reached packaged");
      Loading.show(context);
      //    showLoading(context);
      Agentprofileviewmodel datas =
          await Schemelistgetprofile.getprofileagent();
      //  Navigator.of(context).pop(true);
      // showLoading(context);
      setState(() {
        Loading.dismiss();
        data = datas;
        print(data);

        nameController.text = data!.data!.userId!.agentName!;
        emailController.text = data!.data!.userId!.email!;
        phoneController.text = data!.data!.userId!.phone!;
        pancardController.text = data!.data!.userId!.panNumber!;
        adharController.text = data!.data!.userId!.adhaar!;
        addressController.text = data!.data!.userId!.address!;

        //  test();
      });
    } catch (e) {
      showErrorMessage(e);
      Loading.dismiss();
      //  Navigator.pop(context);
    }
  }

  Future<void> postedit(Map details) async {
    try {
      Loading.show(context);
      print(details);
      //    showLoading(context);

      Profileditpostmodel data =
          await Schemelistgetprofile.postprofileagentEdit(details);
      Loading.dismiss();
      setState(() {
        edit = false;
      });

      //  Navigator.of(context).pop(true);
      // showLoading(context);
      // setState(() {
      //   EasyLoading.dismiss();
      //   data = datas;
      //   print(data);
      //   //  test();
      // });
    } catch (e) {
      print(e);
      // showErrorMessage(e);
      Loading.dismiss();
      //  Navigator.pop(context);
    }
  }

  bool validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{6,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      showToast('Please enter mobile number');
      return false;
    } else if (!regExp.hasMatch(value)) {
      showToastCenter('Please enter valid mobile number');
      return false;
    }
    return true;
  }
}
