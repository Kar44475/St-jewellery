import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/Utils.dart';
import 'package:stjewellery/Widgets/Inputdropdown.dart';
import 'package:stjewellery/Widgets/TextFieldWidget.dart';
import 'package:stjewellery/model/Countymodel.dart';
import 'package:stjewellery/model/agentregisterationmodel.dart';
import 'package:stjewellery/model/districtmodel.dart';
import 'package:stjewellery/model/statemodel.dart';
import 'package:stjewellery/service/Registrationservice.dart';
import 'package:stjewellery/service/locationservice.dart';

class Agenstregistration extends StatefulWidget {
  @override
  _AgenstregistrationState createState() => _AgenstregistrationState();
}

class _AgenstregistrationState extends State<Agenstregistration> {
  String countrycode = "+91";
  List<String> countrys = [];
  List<int> countryid = [];
  List<String> states = [];
  List<int> stateid = [];
  List<String> districts = [];
  List<int> districtid = [];
  // List<String> branch = [];
  // List<int> branchid = [];
  String? selectedstate;
  String? selectedbranch;
  //String mobilenumber;
  String? selecteddistrict;
  String? dob;
  String? selectedcountry;
  TextEditingController nameController = TextEditingController();
  TextEditingController dateofbirthcontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pancardController = TextEditingController();
  TextEditingController adharController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController nomininameController = TextEditingController();
  TextEditingController nominirelationController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController nominiphoneController = TextEditingController();
  TextEditingController refereid = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    //getCountry();
    super.initState();
    getAgent();
    // getBranch();
    // getRefaral();
  }

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1930, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dob = picked.toString().substring(0, 10);
        dateofbirthcontroller.text = DateFormat(
          'dd  MMM, yyyy',
        ).format(DateTime.parse(dob!)).toString();
      });
    }
  }

  String agentid = "";
  int? branchid;
  getAgent() async {
    String s = await getSavedObject("referalId");
    int branch = await getSavedObject("branch");

    print(branch);
    if (s != null) agentid = s;
    if (branch != null) branchid = branch;
    getCountry(branchid!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Customer Registration")),
      body: Container(
        decoration: const BoxDecoration(),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
              child: Card(
                color: Colors.white,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Wrap(
                    runSpacing: 5,
                    children: [
                      CapitalTextfliedwidgetBlack(
                        edit: nameController,
                        label: "Name",
                        keyboard: TextInputType.name,
                      ),
                      TextfliedwidgetBlack(
                        edit: emailController,
                        label: "Email",
                        keyboard: TextInputType.emailAddress,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: 48,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                ),
                                child: CountryCodePicker(
                                  padding: EdgeInsets.zero,
                                  onChanged: (print) {
                                    countrycode = print.dialCode!;
                                  },
                                  textStyle: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: ColorUtil.fromHex("#645D5D"),
                                  ),
                                  initialSelection: '+91',
                                  favorite: ['+91', '+93'],
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  showFlag: false,
                                  showFlagDialog: true,
                                  alignLeft: false,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextfliedwidgetBlack(
                              edit: phoneController,
                              label: "Phone",
                              keyboard: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 48,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: TextField(
                                  controller: dateofbirthcontroller,
                                  style: const TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    suffixIcon: const Icon(
                                      Icons.calendar_month,
                                    ),
                                    border: InputBorder.none,
                                    //   hintStyle:  TextStyle(color: ColorUtil.fromHex("#979797"),fontSize: 13),
                                    enabled: false,
                                    hintText: "Date Of Birth",
                                    hintStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                    ),
                                  ),

                                ),                              ),
                            ),
                          ),
                        ),
                      ),
                      CapitalTextfliedwidgetBlack(
                        edit: nomininameController,
                        label: "Nominee Name",
                        keyboard: TextInputType.emailAddress,
                      ),
                      TextfliedwidgetBlack(
                        edit: nominiphoneController,
                        label: "Nominee Phone",
                        keyboard: TextInputType.phone,
                      ),
                      TextfliedwidgetBlack(
                        edit: nominirelationController,
                        label: "Nominee Relation",
                        keyboard: TextInputType.emailAddress,
                      ),
                      Divider(
                        color: ColorUtil.fromHex("#D4D4D4"),
                        thickness: 1.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                        child: Text(
                          "Pan Card Or Aadhaar Card",
                          style: font(12, Colors.black, FontWeight.w500),
                        ),
                      ),
                      TextfliedwidgetBlack(
                        edit: pancardController,
                        label: "Pan Card",
                        keyboard: TextInputType.text,
                      ),
                      TextfliedwidgetBlack(
                        edit: adharController,
                        label: "Aadhaar Card",
                        keyboard: TextInputType.number,
                      ),

                      TextfliedwidgetBlack(
                        edit: pincodeController,
                        label: "Pincode",
                        keyboard: TextInputType.number,
                      ),

                      Divider(
                        color: ColorUtil.fromHex("#D4D4D4"),
                        thickness: 1.5,
                      ),

                      // Divider(
                      //                       color: ColorUtil.fromHex("#D4D4D4"),
                      //                       thickness: 1.5,
                      //                     ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        child: Text(
                          "Upload Aadhaar Card",
                          style: font(12, Colors.black, FontWeight.w500),
                        ),
                      ),
                      (_image == null)
                          ? Padding(
                              padding: const EdgeInsets.only(
                                left: 25.0,
                                right: 25,
                              ),
                              child: Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  // color: ColorUtil.fromHex("#461524"),
                                  border: Border.all(
                                    color: ColorUtil.fromHex("#461524"),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Upload",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: ColorUtil.fromHex("#461524"),
                                        ),
                                      ),
                                      w(5),
                                      Icon(
                                        Icons.upload,
                                        color: ColorUtil.fromHex("#461524"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                left: 25.0,
                                right: 25,
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorUtil.fromHex("#461524"),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image: FileImage(File(_image!.path)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    color: Colors.blueGrey,
                                    child: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _image = null;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),

                      const SizedBox(height: 10),

                      Divider(
                        color: ColorUtil.fromHex("#D4D4D4"),
                        thickness: 1.5,
                      ),
                      const SizedBox(height: 5),

                      SubmitSelectInputBorder(
                        label: "",
                        dropdownValue: selectedcountry,
                        hint: "Country",
                        listvalues: countrys,
                        onChanged: (value) {
                          setState(() {
                            selectedcountry = value;
                            selectedstate = null;
                            selecteddistrict = null;
                          });
                          getState(
                            countryid
                                .elementAt(countrys.indexOf(selectedcountry!))
                                .toString(),
                          );
                        },
                      ),
                      SubmitSelectInputBorder(
                        label: "",
                        dropdownValue: selectedstate,
                        hint: "State",
                        listvalues: states,
                        onChanged: (value) {
                          setState(() {
                            selectedstate = value;
                            selecteddistrict = null;
                          });
                          getDistrict(
                            stateid
                                .elementAt(states.indexOf(selectedstate!))
                                .toString(),
                          );
                        },
                      ),
                      SubmitSelectInputBorder(
                        label: "",
                        dropdownValue: selecteddistrict,
                        hint: "District",
                        listvalues: districts,
                        onChanged: (value) {
                          setState(() {
                            selecteddistrict = value;
                          });
                        },
                      ),
                      Divider(
                        color: ColorUtil.fromHex("#D4D4D4"),
                        thickness: 1.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20,
                          bottom: 10,
                        ),
                        child: Messageview(
                          controller: messageController,
                          height: 200,
                          label: "Address",
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: bttn2("Submit", () {
                            if (nameController.text.toString().compareTo("") ==
                                0) {
                              showToast("Please enter name");
                            }
                            if (phoneController.text.toString().compareTo("") ==
                                0) {
                              showToast("Please enter phone");
                            }
                            if (messageController.text.toString().compareTo(
                                  "",
                                ) ==
                                0) {
                              showToast("Please enter your address");
                            } else if (selectedcountry == null) {
                              showToast("Please select country");
                            } else if (selectedstate == null) {
                              showToast("Please select state");
                            } else if (selecteddistrict == null) {
                              showToast("Please select district");
                            } else {
                              {
                                Map b = {
                                  "name": nameController.text.toString(),
                                  "email": emailController.text.toString(),
                                  "phone":
                                      countrycode +
                                      phoneController.text.toString(),
                                  "pancard": pancardController.text.toString(),
                                  "adhaarcard": adharController.text.toString(),
                                  "dob": dob,
                                  "referalId": agentid,
                                  "address": messageController.text.toString(),
                                  "nominee_relation": nominirelationController
                                      .text
                                      .toString(),
                                  "nominee_phone": nominiphoneController.text
                                      .toString(),
                                  "nominee": nomininameController.text
                                      .toString(),
                                  "district": districtid.elementAt(
                                    districts.indexOf(selecteddistrict!),
                                  ),
                                  "branchId": branchid,
                                  "adhar": _image == null ? null : _image!.path,
                                  "state": stateid.elementAt(
                                    states.indexOf(selectedstate!),
                                  ),
                                  "country": countryid.elementAt(
                                    countrys.indexOf(selectedcountry!),
                                  ),
                                  "pincode": pincodeController.text.toString(),
                                };

                                postRegistration(b);
                              }
                              // Navigator.pushNamed(
                              //   context,
                              //   SelectPackage.routeName,
                              // );
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            h(ScreenSize.setHeight(context, 0.05)),
          ],
        ),
      ),
    );
  }

  Future<void> getCountry(int branchid) async {
    print(branchid);
    countryid.clear();
    countrys.clear();
    states.clear();
    districtid.clear();
    districts.clear();
    stateid.clear();

    try {
      Loading.show(context);
      //    showLoading(context);
      Countrymodel country = await Locationservice.getCountry(branchid);
      Loading.dismiss();
      setState(() {
        countrys = country.data.countryList.map((e) => e.countryName).toList();
        countryid = country.data.countryList.map((e) => e.id).toList();
      });
    } catch (e) {
      print(e);
      Loading.dismiss();
    }
  }

  Future<void> getState(String id) async {
    districtid.clear();
    districts.clear();
    try {
      Loading.show(context);
      //    showLoading(context);
      Statemodel state = await Locationservice.getState(id);
      Loading.dismiss();
      setState(() {
        states = state.data.stateList.map((e) => e.stateName).toList();
        stateid = state.data.stateList.map((e) => e.id).toList();
      });
    } catch (e) {
      print(e);
      // showErrorMessage(e);
      Loading.dismiss();
      //  Navigator.pop(context);
    }
  }

  Future<void> getDistrict(String id) async {
    try {
      Loading.show(context);
      //    showLoading(context);
      Districtmodel district = await Locationservice.getDistrict(id);
      Loading.dismiss();
      setState(() {
        districts = district.data.districtsList
            .map((e) => e.districtName)
            .toList();
        districtid = district.data.districtsList.map((e) => e.id).toList();
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

  Future<void> postRegistration(Map details) async {
    try {
      print(details);
      Loading.show(context);
      //    showLoading(context);
      Agentregisterationmodel data =
          await Registrationservice.getagentRegistration(details);
      Loading.dismiss();

      Navigator.pop(context, true);
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

  // Future<void> getBranch() async {
  //   branch.clear();
  //   branchid.clear();

  //   try {
  //     EasyLoading.show(status: 'Loading...');
  //     //    showLoading(context);
  //     BranchListModel branchs = await Branchservice.getBranch();
  //     EasyLoading.dismiss();
  //     setState(() {
  //       branch = branchs.data.branches.map((e) => e.name).toList();
  //       branchid = branchs.data.branches.map((e) => e.id).toList();
  //     });
  //   } catch (e) {
  //     print(e);
  //     // showErrorMessage(e);
  //     EasyLoading.dismiss();
  //     //  Navigator.pop(context);
  //   }
  // }
}
