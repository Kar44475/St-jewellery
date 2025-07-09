import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stjewellery/support_widget/essential.dart';
import 'package:stjewellery/Widgets/SubmitinputText.dart';
import 'package:stjewellery/Widgets/SubmitinputTextfocus.dart';
import 'package:stjewellery/model/agent_profile_view_model.dart';
import 'package:stjewellery/service/profileeditservice.dart';

class AgentProfileView extends StatefulWidget {
  const AgentProfileView({super.key});

  @override
  AgentProfileViewState createState() => AgentProfileViewState();
}

class AgentProfileViewState extends State<AgentProfileView> {
  static const Duration _focusDelay = Duration(seconds: 1);
  static const String _emptyString = "";

  DateTime selectedDate = DateTime.now();
  final FocusNode _nameFocusNode = FocusNode();

  Agentprofileviewmodel? _agentProfileData;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _panCardController = TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchProfileDetails();
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _panCardController.dispose();
    _aadhaarController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(),
        child: SafeArea(
          child: ListView(children: [_buildAppBar(), _buildProfileCard()]),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Text("Profile"),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNameField(),
              _buildEmailField(),
              _buildPhoneField(),
              _buildAadhaarField(),
              _buildPanCardField(),
              _buildAddressField(),
              _buildActionButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 0, top: 10),
      child: SubmitTextInputTextfocus(
        controller: _nameController,
        edit: _isEditMode,
        fcous: _nameFocusNode,
        label: "First Name",
        keyboard: TextInputType.name,
        hint: _emptyString,
      ),
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 0, top: 10),
      child: SubmitTextInput(
        textcolor: ColorUtil.fromHex("#000000"),
        controller: _emailController,
        edit: false,
        label: "Email",
        keyboard: TextInputType.emailAddress,
        hint: _emptyString,
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 15, bottom: 0),
      child: SubmitTextInput(
        textcolor: ColorUtil.fromHex("#000000"),
        controller: _phoneController,
        label: "Phone",
        edit: false,
        keyboard: TextInputType.phone,
        hint: _emptyString,
      ),
    );
  }

  Widget _buildAadhaarField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 15, bottom: 5),
      child: SubmitTextInput(
        textcolor: ColorUtil.fromHex("#000000"),
        controller: _aadhaarController,
        label: "Aadhaar",
        edit: _isEditMode,
        keyboard: TextInputType.phone,
        hint: _emptyString,
      ),
    );
  }

  Widget _buildPanCardField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 15, bottom: 5),
      child: SubmitTextInput(
        textcolor: ColorUtil.fromHex("#000000"),
        controller: _panCardController,
        label: "Pan Card",
        edit: _isEditMode,
        keyboard: TextInputType.text,
        hint: _emptyString,
      ),
    );
  }

  Widget _buildAddressField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 15, bottom: 5),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _addressController,
            enabled: _isEditMode,
            style: TextStyle(fontSize: 14, color: ColorUtil.fromHex("#262626")),
            minLines: 10,
            textInputAction: TextInputAction.done,
            maxLines: 15,
            autocorrect: false,
            decoration: InputDecoration(
              fillColor: ColorUtil.fromHex("#ffffff"),
              hintText: "Address",
              hintStyle: TextStyle(color: ColorUtil.fromHex("#262626")),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: secondaryButton(
          _isEditMode ? "Save" : "Edit",
          _handleButtonPress,
        ),
      ),
    );
  }

  void _handleButtonPress() {
    if (!_isEditMode) {
      _enableEditMode();
    } else {
      _validateAndSaveProfile();
    }
  }

  void _enableEditMode() {
    setState(() {
      _isEditMode = true;
    });
    Timer(_focusDelay, () {
      FocusScope.of(context).requestFocus(_nameFocusNode);
    });
  }

  void _validateAndSaveProfile() {
    if (_isNameEmpty()) {
      showToast("Please enter name");
      return;
    }

    if (_areDocumentsEmpty()) {
      showToast("Please enter Pancard or Aadhaar card details");
      return;
    }

    _saveProfile();
  }

  bool _isNameEmpty() {
    return _nameController.text.trim().isEmpty;
  }

  bool _areDocumentsEmpty() {
    return _aadhaarController.text.trim().isEmpty &&
        _panCardController.text.trim().isEmpty;
  }

  void _saveProfile() {
    final Map<String, String> profileData = {
      "agentName": _nameController.text.trim(),
      "email": _emailController.text.trim(),
      "phone": _agentProfileData!.data!.userId!.phone!,
      "pancard": _panCardController.text.trim(),
      "adhaar": _aadhaarController.text.trim(),
      "address": _addressController.text.trim(),
    };

    _submitProfileEdit(profileData);
  }

  Future<void> _fetchProfileDetails() async {
    try {
      print("Fetching profile details");
      Loading.show(context);

      final Agentprofileviewmodel profileData =
          await Schemelistgetprofile.getprofileagent();

      setState(() {
        Loading.dismiss();
        _agentProfileData = profileData;
        _populateControllers();
      });
    } catch (error) {
      showErrorMessage(error);
      Loading.dismiss();
    }
  }

  void _populateControllers() {
    if (_agentProfileData?.data?.userId != null) {
      final userData = _agentProfileData!.data!.userId!;
      _nameController.text = userData.agentName ?? _emptyString;
      _emailController.text = userData.email ?? _emptyString;
      _phoneController.text = userData.phone ?? _emptyString;
      _panCardController.text = userData.panNumber ?? _emptyString;
      _aadhaarController.text = userData.adhaar ?? _emptyString;
      _addressController.text = userData.address ?? _emptyString;
    }
  }

  Future<void> _submitProfileEdit(Map<String, String> profileDetails) async {
    try {
      Loading.show(context);
      print("Submitting profile edit: $profileDetails");

      await Schemelistgetprofile.postprofileagentEdit(profileDetails);

      Loading.dismiss();
      setState(() {
        _isEditMode = false;
      });
    } catch (error) {
      print("Profile edit error: $error");
      Loading.dismiss();
    }
  }

  bool validateMobile(String phoneNumber) {
    const String phonePattern = r'(^(?:[+0]9)?[0-9]{6,12}$)';
    final RegExp phoneRegExp = RegExp(phonePattern);

    if (phoneNumber.isEmpty) {
      showToast('Please enter mobile number');
      return false;
    } else if (!phoneRegExp.hasMatch(phoneNumber)) {
      showToastCenter('Please enter valid mobile number');
      return false;
    }
    return true;
  }
}
