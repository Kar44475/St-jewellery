import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/Utils.dart';
import 'package:stjewellery/Widgets/Inputdropdown.dart';
import 'package:stjewellery/Widgets/TextFieldWidget.dart';
import 'package:stjewellery/model/BranchListModel.dart';
import 'package:stjewellery/model/Countymodel.dart';
import 'package:stjewellery/model/Registrationmodel.dart';
import 'package:stjewellery/model/districtmodel.dart';
import 'package:stjewellery/model/referal_model.dart';
import 'package:stjewellery/model/statemodel.dart';
import 'package:stjewellery/screens/PackagesScreen/SelectNewScheme.dart';
import 'package:stjewellery/service/Registrationservice.dart';
import 'package:stjewellery/service/branchservice.dart';
import 'package:stjewellery/service/locationservice.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class Registration extends StatefulWidget {
  final phone;
  const Registration({Key? key, this.phone}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isTabBarEnabled = false;

  TextEditingController FirstNameController = TextEditingController();
  TextEditingController LastNameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController dateofbirthcontroller = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  String? firebasetoken;
  List<String> countrys = [];
  List<int> countryid = [];
  List<String> states = [];
  List<int> stateid = [];
  List<String> districts = [];
  List<int> districtid = [];
  List<String> branch = [];
  List<int> branchid = [];
  List<String> branchRef = [];

  String? selectedcountry;
  String? selectedbranch;
  String? selecteddistrict;
  String? selectedstate;

  DateTime selectedDate = DateTime.now();
  var dob;
  Map phone = Map();

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
        ).format(DateTime.parse(dob)).toString();
      });
    }
  }

  @override
  void initState() {
    getBranch();
    getRefaral();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          // Top section with back button and logo - FIXED OVERFLOW
          Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              child: SafeArea(
                child: Column(
                  children: [
                    // Back button
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    // Logo and title - WRAPPED IN FLEXIBLE TO PREVENT OVERFLOW
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Constrained logo size
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: screenWidth * 0.2,
                              maxHeight: screenWidth * 0.2,
                            ),
                            child: Image.asset(
                              "assets/pngIcons/mainIcons.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 8),
                          // Constrained text
                          Flexible(
                            child: Text(
                              "USER REGISTRATION",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 4),
                          Flexible(
                            child: Text(
                              "Complete your profile to get started",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom section with form - ADJUSTED FLEX
          Expanded(
            flex: 2,
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    // Custom Tab Bar
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromRGBO(255, 203, 3, 0.15),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        onTap: (index) {
                          if (!isTabBarEnabled && index != 0) {
                            _tabController.animateTo(0);
                            showSnackBar(
                              context,
                              "Please complete this form to continue.",
                            );
                          }
                        },
                        tabs: const [
                          Tab(text: "Personal Info"),
                          Tab(text: "Contact Details"),
                        ],
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                        indicatorPadding: const EdgeInsets.all(4),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Tab Content
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [personalTab(), contactDetailsTab()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  personalTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
      child: Column(
        children: [
          // Enhanced Text Fields with consistent styling
          _buildTextField(
            controller: FirstNameController,
            label: "First Name",
            icon: Icons.person_outline,
          ),
          SizedBox(height: 16),
          _buildTextField(
            controller: LastNameController,
            label: "Last Name",
            icon: Icons.person_outline,
          ),
          SizedBox(height: 16),
          _buildTextField(
            controller: EmailController,
            label: "Email Address",
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16),
          // Enhanced Date Picker
          InkWell(
            onTap: () => _selectDate(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 203, 3, 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      dateofbirthcontroller.text.isEmpty
                          ? "Date of Birth"
                          : dateofbirthcontroller.text,
                      style: TextStyle(
                        fontSize: 14,
                        color: dateofbirthcontroller.text.isEmpty
                            ? Colors.grey[600]
                            : Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          // Enhanced Next Button
          Container(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                if (FirstNameController.text.isEmpty ||
                    LastNameController.text.isEmpty ||
                    EmailController.text.isEmpty ||
                    dateofbirthcontroller.text.isEmpty) {
                  showSnackBar(context, "Please fill all fields");
                } else {
                  setState(() {
                    isTabBarEnabled = true;
                  });
                  if (_tabController.index < _tabController.length - 1) {
                    _tabController.animateTo(1);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Next",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  contactDetailsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Enhanced Dropdowns
          _buildDropdown(
            value: selectedbranch,
            hint: "Select Branch",
            icon: Icons.business_outlined,
            items: branch,
            onChanged: (value) {
              setState(() {
                selectedbranch = value!;
                selectedcountry = null;
                selecteddistrict = null;
                selectedstate = null;
                referralController.text = branchRef.elementAt(
                  branch.indexOf(selectedbranch!),
                );
              });
              getCountry(branchid.elementAt(branch.indexOf(selectedbranch!)));
            },
          ),
          SizedBox(height: 16),
          _buildDropdown(
            value: selectedcountry,
            hint: "Select Country",
            icon: Icons.public_outlined,
            items: countrys,
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
          SizedBox(height: 16),
          _buildDropdown(
            value: selectedstate,
            hint: "Select State",
            icon: Icons.location_city_outlined,
            items: states,
            onChanged: (value) {
              setState(() {
                selectedstate = value;
                selecteddistrict = null;
              });
              getDistrict(
                stateid.elementAt(states.indexOf(selectedstate!)).toString(),
              );
            },
          ),
          SizedBox(height: 16),
          _buildDropdown(
            value: selecteddistrict,
            hint: "Select District",
            icon: Icons.location_on_outlined,
            items: districts,
            onChanged: (value) {
              setState(() {
                selecteddistrict = value;
              });
            },
          ),
          SizedBox(height: 16),
          // Enhanced Address Field
          _buildTextField(
            controller: addressController,
            label: "Address",
            icon: Icons.home_outlined,
            maxLines: 3,
          ),
          SizedBox(height: 16),
          // Enhanced Referral Field
          _buildTextField(
            controller: referralController,
            label: "Referral Code",
            icon: Icons.card_giftcard_outlined,
          ),
          SizedBox(height: 40),
          // Enhanced Register Button
                  // Enhanced Register Button
          Container(
            width: double.infinity,
            height: 56,
            child: bttnPressed == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      if (referralController.text.toString().compareTo("") == 0) {
                        showSnackBar(
                          context,
                          "Please enter referral code. If you don't have reference code please contact admin using WhatsApp!",
                        );
                      } else if (selectedbranch == null) {
                        showSnackBar(context, "Please select branch");
                      } else if (selectedcountry == null) {
                        showSnackBar(context, "Please select country");
                      } else if (selectedstate == null) {
                        showSnackBar(context, "Please select state");
                      } else if (selecteddistrict == null) {
                        showSnackBar(context, "Please select district");
                      } else {
                        setState(() {
                          bttnPressed = true;
                        });
                        Map b = {
                          "name":
                              "${FirstNameController.text} ${LastNameController.text}",
                          "email": EmailController.text.toString(),
                          "phone": widget.phone.toString(),
                          "pancard": "",
                          "adhaarcard": "",
                          "dob": dob.toString() == "null" ? "" : dob.toString(),
                          "referalId": referralController.text.toString(),
                          "address": addressController.text.toString(),
                          "nominee_relation": "",
                          "nominee_phone": "",
                          "FcmToken": firebasetoken,
                          "nominee": "",
                          "district": districtid.elementAt(
                            districts.indexOf(selecteddistrict!),
                          ),
                          "adhar": "",
                          "branchId": branchid.elementAt(
                            branch.indexOf(selectedbranch!),
                          ),
                          "state": stateid.elementAt(states.indexOf(selectedstate!)),
                          "country": countryid.elementAt(
                            countrys.indexOf(selectedcountry!),
                          ),
                          "pincode": "",
                        };
                        postRegistration(b);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Helper method for consistent text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 203, 3, 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: Icon(
            icon,
            color: Colors.grey[600],
            size: 20,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  // Helper method for consistent dropdowns
  Widget _buildDropdown({
    required String? value,
    required String hint,
    required IconData icon,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 203, 3, 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey[600],
              size: 20,
            ),
            SizedBox(width: 12),
            Text(
              hint,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.grey[600],
        ),
        dropdownColor: Colors.white,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }

  // Your existing service methods remain the same
  Future<void> getRefaral() async {
    try {
      phone.clear();
      Loading.show(context);
      ReferalModal branchs = await Branchservice.getRefaral();
      branchs.data.defaultRefaral.forEach((element) {
        phone[element.branchId] = element.reqMob;
      });
      Loading.dismiss();
    } catch (e) {
      Loading.dismiss();
      print(e);
    }
  }

  Future<void> getBranch() async {
    branch.clear();
    branchid.clear();
    branchRef.clear();
    try {
      BranchListModel branchs = await Branchservice.getBranch();
      setState(() {
        branch = branchs.data.branches.map((e) => e.name).toList();
        branchid = branchs.data.branches.map((e) => e.id).toList();
        branchRef = branchs.data.branches.map((e) => e.referalId!).toList();
      });
    } catch (e) {
      print(e);
      Loading.dismiss();
    }
  }

  Future<void> getCountry(int branchid) async {
    print("branch IDD: " + branchid.toString());
    countryid.clear();
    countrys.clear();
    states.clear();
    districtid.clear();
    districts.clear();
    stateid.clear();
    try {
      Loading.show(context);
      Countrymodel country = await Locationservice.getCountry(branchid);
      setState(() {
        countrys = country.data.countryList.map((e) => e.countryName).toList();
        countryid = country.data.countryList.map((e) => e.id).toList();
      });
      Loading.dismiss();
    } catch (e) {
      Loading.dismiss();
      print(e);
    }
  }

  Future<void> getState(String id) async {
    districtid.clear();
    districts.clear();
    try {
      Loading.show(context);
      Statemodel state = await Locationservice.getState(id);
      Loading.dismiss();
      setState(() {
        states = state.data.stateList.map((e) => e.stateName).toList();
        stateid = state.data.stateList.map((e) => e.id).toList();
      });
    } catch (e) {
      print(e);
      Loading.dismiss();
    }
  }

  Future<void> getDistrict(String id) async {
    try {
      Loading.show(context);
      Districtmodel district = await Locationservice.getDistrict(id);
      Loading.dismiss();
      setState(() {
        districts = district.data.districtsList
            .map((e) => e.districtName)
            .toList();
        districtid = district.data.districtsList.map((e) => e.id).toList();
      });
    } catch (e) {
      print(e);
      Loading.dismiss();
    }
  }

  bool bttnPressed = false;
  Future<void> postRegistration(Map details) async {
    try {
      Registrationmodel? data = await Registrationservice.getRegistration(
        details,
      );
      if (data!.data!.status == "200") {
        print("successs 1");
        showSnackBar(context, "Registration complete!");
        setState(() {
          bttnPressed = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SelectNewScheme()),
        );
      } else {
        print("failll 1");
        setState(() {
          bttnPressed = false;
        });
        showToast(data.message.toString());
      }
    } catch (e) {
      print("herre");
      setState(() {
        bttnPressed = false;
      });
      print(e);
      Loading.dismiss();
    }
  }
}
