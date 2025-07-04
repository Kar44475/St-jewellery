import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Drawer_Pages/drawer.dart';
import 'package:stjewellery/Utils/Utils.dart';
import 'package:stjewellery/Widgets/exitwidget.dart';
import 'package:stjewellery/model/profileeditmodel.dart';
import 'package:stjewellery/model/profileeditpostmodel.dart';
import 'package:stjewellery/screens/Notification/NotificationsScreen.dart';
import 'package:stjewellery/service/profileeditservice.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedGender = 'male';
  int? role;

  getrole() async {
    role = await getSavedObject("roleid");
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getProfileDetails();
      getrole();
    });
    _loadSavedGender();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  FocusNode focus = FocusNode();

  Future<void> _loadSavedGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedGender = prefs.getString('selectedGender') ?? 'male';
    });
  }

  Future<void> _saveGender(String gender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedGender', gender);
  }

void _showBottomDrawer(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
            // Handle bar
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Drawer content
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: DrawerWidget(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Scaffold(
    //         appBar: AppBar(
    //            elevation: 0,
    // leading: role == 2 || role == 4 
    //   ? IconButton(
    //       icon: Icon(Icons.menu, color: Colors.white),
    //       onPressed: () {
    //         _showBottomDrawer(context);
    //       },
    //     )
    //   : null,
    //           backgroundColor: Theme.of(context).primaryColor,
    //           title: Image.asset(
    //             "assets/pngIcons/mainIcons.png",
    //             height: 55,
               
    //           ),

    //               actions: [
    //   IconButton(
    //     onPressed: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const Notificationsscreen(),
    //         ),
    //       );
    //     },
    //     icon: const Icon(Icons.notifications, size: 25, color: Colors.white),
    //   ),
    // ],
    //         ),
            body: Container(
              color: Colors.white,
              child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 20, bottom: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Icon and Name Row
                      Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showGenderSelectionDialog(context);
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              child: Lottie.asset(
                                selectedGender == 'male'
                                    ? 'assets/male.json'
                                    : 'assets/female.json',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              nameController.text.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
              
                    // User Details Container - Smaller and Full Width
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 203, 3, 1),
                    
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "User Details",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showEditDialog(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                     
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    CupertinoIcons.pencil,
                                    size: 17,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
              
                    // First Details Grid with White Background
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            // Left Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetailItem(
                                    "Full Name",
                                    nameController.text.toString(),
                                  ),
                                  SizedBox(height: 20),
                                  _buildDetailItem(
                                    "Mobile",
                                    "${phoneController.text}",
                                  ),
                                  SizedBox(height: 20),
                                  _buildDetailItem(
                                    "PAN Card",
                                    data?.data?.userId?.pancard ?? "Not Available",
                                  ),
                                  SizedBox(height: 20),
                                  _buildDetailItem(
                                    "Address",
                                    data?.data?.userId?.address ?? "Not Available",
                                  ),
                                ],
                              ),
                            ),
                      
                            // Vertical Divider
                            Container(
                              width: 1,
                              height: 200,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                            ),
                      
                            // Right Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetailItem(
                                    "Email",
                                    emailController.text.toString(),
                                  ),
                                  SizedBox(height: 20),
                                  _buildDetailItem(
                                    "Aadhaar Card",
                                    data?.data?.userId?.adhaarcard ??
                                        "Not Available",
                                  ),
                                  SizedBox(height: 20),
                                  _buildDetailItem(
                                    "Referral ID",
                                    data?.data?.userId?.referalId ??
                                        "Not Available",
                                  ),
                                  SizedBox(height: 20),
                                  _buildDetailItem(
                                    "Date of Birth",
                                    data?.data?.userId?.dob != null
                                        ? "${data!.data!.userId!.dob!.day}/${data!.data!.userId!.dob!.month}/${data!.data!.userId!.dob!.year}"
                                        : "Not Available",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20), // 20px gap between sections
                    
                    // Additional Details Container
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 203, 3, 1),
                      ),
                      child: Text(
                        "Additional Information",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    
                    // Second Details Grid with Additional Information - REARRANGED
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            // Left Column - Redistributed items
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetailItem(
                                    "Registration Number",
                                    data?.data?.userId?.registrationNumber ?? "Not Available",
                                  ),
                                  SizedBox(height: 20),
                                  _buildDetailItem(
                                    "Branch ID",
                                    data?.data?.userId?.branchId?.toString() ?? "Not Available",
                                  ),
                                  SizedBox(height: 20),
                                  _buildDetailItem(
                                    "A/C Number",
                                    data?.data?.userId?.aCNumber?.toString() ?? "Not Available",
                                  ),
                                  SizedBox(height: 20),
                                  _buildDetailItem(
                                    "Nominee",
                                    data?.data?.userId?.nominee ?? "Not Available",
                                  ),
                                ],
                              ),
                            ),
                      
                            // Vertical Divider - Adjusted height
                            Container(
                              width: 1,
                              height: 200,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                            ),
                      
                            // Right Column - Redistributed items
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetailItem(
                                    "Pincode",
                                    data?.data?.userId?.pincode ?? "Not Available",
                                  ),
                                  SizedBox(height: 20),
                                  _buildDetailItem(
                                    "Nominee Relation",
                                    data?.data?.userId?.nomineeRelation ?? "Not Available",
                                  ),
                                  SizedBox(height: 20),
                                  _buildDetailItem(
                                    "Nominee Phone",
                                    data?.data?.userId?.nomineePhone ?? "Not Available",
                                  ),
                                  SizedBox(height: 20),
                                  _buildDetailItem(
                                    "Points",
                                    data?.data?.userId?.point ?? "Not Available",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20), // 20px gap between sections
                    
              
                  ],
                ),
              ),
            ),
          ),

          // Back Button for non-admin users
          role == 2 || role == 4
              ? SizedBox.shrink()
              : Positioned(
                  top: 40,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

   Widget _buildDetailItem(String heading, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(120, 131, 141, 1),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context) {
    final TextEditingController dialogNameController = TextEditingController();
    final TextEditingController dialogEmailController = TextEditingController();
    
    // Pre-fill with current values
    dialogNameController.text = nameController.text;
    dialogEmailController.text = emailController.text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name Field
                TextFormField(
                  controller: dialogNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  ),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                
                // Email Field
                TextFormField(
                  controller: dialogEmailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  ),
                  style: TextStyle(fontSize: 16),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (dialogNameController.text.trim().isEmpty) {
                  showToast("Please enter name");
                  return;
                }
                
                // Update the main controllers
                nameController.text = dialogNameController.text;
                emailController.text = dialogEmailController.text;
                
                // Prepare data for API call
                Map b = {
                  "name": dialogNameController.text.toString(),
                  "email": dialogEmailController.text.toString(),
                  "phone": data!.data!.userId!.phone!,
                  "pancard": data!.data!.userId!.pancard,
                  "adhaarcard": data!.data!.userId!.adhaarcard,
                  "dob": data!.data!.userId!.dob,
                  "referalId": data!.data!.userId!.referalId,
                  "address": data!.data!.userId!.address,
                  "nominee_relation": data!.data!.userId!.nomineeRelation,
                  "nominee_phone": data!.data!.userId!.nomineePhone,
                  "nominee": data!.data!.userId!.nominee,
                  "district": data!.data!.userId!.district,
                  "state": data!.data!.userId!.state,
                  "country": data!.data!.userId!.country,
                  "pincode": data!.data!.userId!.pincode,
                };
                
                Navigator.of(context).pop();
                postedit(b);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showGenderSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Gender',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: 'male',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
                      });
                      _saveGender(value!);
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text('Male'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'female',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
                      });
                      _saveGender(value!);
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text('Female'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  bool loaddd = true;
  Profileditmodel? data;

  getProfileDetails() async {
    try {
      print("reached packaged");
      Loading.show(context);
      Profileditmodel datas = await Schemelistgetprofile.getprofile();

      setState(() {
        loaddd = false;
        data = datas;
        print(data);
        nameController.text = data!.data!.userId!.name!;
        emailController.text = data!.data!.userId!.email!;
        phoneController.text = data!.data!.userId!.phone!;
      });
      Loading.dismiss();
    } catch (e) {
      print("catchhhh");
      Loading.dismiss();

      setState(() {
        loaddd = false;
      });
      showErrorMessage(e);
    }
  }

  bool edit = false;

  Future<void> postedit(Map details) async {
    try {
      Loading.show(context);
      print(details);
      Profileditpostmodel data = await Schemelistgetprofile.postprofileEdit(
        details,
      );
      Loading.dismiss();
      setState(() {
        edit = false;
      });
    } catch (e) {
      print(e);
      Loading.dismiss();
    }
  }
}
