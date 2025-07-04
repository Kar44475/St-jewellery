import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/Widgets/Inputdropdown.dart';
import 'package:stjewellery/Widgets/TextFieldWidget.dart';
import 'package:stjewellery/model/Countymodel.dart';
import 'package:stjewellery/model/agentregisterationmodel.dart';
import 'package:stjewellery/model/districtmodel.dart';
import 'package:stjewellery/model/statemodel.dart';
import 'package:stjewellery/service/Registrationservice.dart';
import 'package:stjewellery/service/locationservice.dart';

class AgentRegistrationScreen extends StatefulWidget {
  const AgentRegistrationScreen({super.key});

  @override
  AgentRegistrationScreenState createState() => AgentRegistrationScreenState();
}

class AgentRegistrationScreenState extends State<AgentRegistrationScreen> {
  // Constants
  static const String _defaultCountryCode = "+91";
  static const String _emptyString = "";
  static const String _phonePattern = r'(^(?:[+0]9)?[0-9]{6,12}$)';
  static const String _dateFormat = 'dd  MMM, yyyy';
  static const int _containerHeight = 48;
  static const int _addressFieldHeight = 200;
  static const int _imageContainerHeight = 100;
  static const int _uploadButtonHeight = 55;

  // Location data
  String _selectedCountryCode = _defaultCountryCode;
  List<String> _countryNames = [];
  List<int> _countryIds = [];
  List<String> _stateNames = [];
  List<int> _stateIds = [];
  List<String> _districtNames = [];
  List<int> _districtIds = [];

  // Selected values
  String? _selectedStateName;
  String? _selectedDistrictName;
  String? _selectedCountryName;
  String? _selectedDateOfBirth;

  // Text Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _panCardController = TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nomineeNameController = TextEditingController();
  final TextEditingController _nomineeRelationController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _nomineePhoneController = TextEditingController();
  final TextEditingController _referralIdController = TextEditingController();

  // Image handling
  File? _selectedAadhaarImage;
  final ImagePicker _imagePicker = ImagePicker();

  // Agent data
  String _agentReferralId = _emptyString;
  int? _branchId;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initializeAgentData();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _nameController.dispose();
    _dateOfBirthController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _panCardController.dispose();
    _aadhaarController.dispose();
    _addressController.dispose();
    _nomineeNameController.dispose();
    _nomineeRelationController.dispose();
    _pincodeController.dispose();
    _nomineePhoneController.dispose();
    _referralIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer Registration")),
      body: Container(
        decoration: const BoxDecoration(),
        child: ListView(
          children: [
            _buildRegistrationCard(),
            SizedBox(height: ScreenSize.setHeight(context, 0.05)),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Wrap(
            runSpacing: 5,
            children: [
              _buildPersonalInfoSection(),
              _buildNomineeSection(),
              _buildDocumentSection(),
              _buildImageUploadSection(),
              _buildLocationSection(),
              _buildAddressSection(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      children: [
        CapitalTextfliedwidgetBlack(
          edit: _nameController,
          label: "Name",
          keyboard: TextInputType.name,
        ),
        TextfliedwidgetBlack(
          edit: _emailController,
          label: "Email",
          keyboard: TextInputType.emailAddress,
        ),
        _buildPhoneNumberRow(),
        _buildDateOfBirthField(),
      ],
    );
  }

  Widget _buildPhoneNumberRow() {
    return Row(
      children: [
        _buildCountryCodePicker(),
        Expanded(
          child: TextfliedwidgetBlack(
            edit: _phoneController,
            label: "Phone",
            keyboard: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _buildCountryCodePicker() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(5),
        ),
        height: _containerHeight.toDouble(),
        child: CountryCodePicker(
          padding: EdgeInsets.zero,
          onChanged: (countryCode) {
            _selectedCountryCode = countryCode.dialCode!;
          },
          textStyle: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: ColorUtil.fromHex("#645D5D"),
          ),
          initialSelection: _defaultCountryCode,
          favorite: const ['+91', '+93'],
          showCountryOnly: false,
          showOnlyCountryWhenClosed: false,
          showFlag: false,
          showFlagDialog: true,
          alignLeft: false,
        ),
      ),
    );
  }

  Widget _buildDateOfBirthField() {
    return InkWell(
      onTap: () => _selectDateOfBirth(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: _containerHeight.toDouble(),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextField(
                controller: _dateOfBirthController,
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: const Icon(Icons.calendar_month),
                  border: InputBorder.none,
                  enabled: false,
                  hintText: "Date Of Birth",
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNomineeSection() {
    return Column(
      children: [
        CapitalTextfliedwidgetBlack(
          edit: _nomineeNameController,
          label: "Nominee Name",
          keyboard: TextInputType.name,
        ),
        TextfliedwidgetBlack(
          edit: _nomineePhoneController,
          label: "Nominee Phone",
          keyboard: TextInputType.phone,
        ),
        TextfliedwidgetBlack(
          edit: _nomineeRelationController,
          label: "Nominee Relation",
          keyboard: TextInputType.text,
        ),
      ],
    );
  }

  Widget _buildDocumentSection() {
    return Column(
      children: [
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
          edit: _panCardController,
          label: "Pan Card",
          keyboard: TextInputType.text,
        ),
        TextfliedwidgetBlack(
          edit: _aadhaarController,
          label: "Aadhaar Card",
          keyboard: TextInputType.number,
        ),
        TextfliedwidgetBlack(
          edit: _pincodeController,
          label: "Pincode",
          keyboard: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      children: [
        Divider(
          color: ColorUtil.fromHex("#D4D4D4"),
          thickness: 1.5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Text(
            "Upload Aadhaar Card",
            style: font(12, Colors.black, FontWeight.w500),
          ),
        ),
        _selectedAadhaarImage == null
            ? _buildUploadButton()
            : _buildImagePreview(),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildUploadButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25),
      child: Container(
        height: _uploadButtonHeight.toDouble(),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: ColorUtil.fromHex("#461524")),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: InkWell(
          onTap: _selectImageFromGallery,
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
              const SizedBox(width: 5),
              Icon(
                Icons.upload,
                color: ColorUtil.fromHex("#461524"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: _imageContainerHeight.toDouble(),
        decoration: BoxDecoration(
          border: Border.all(color: ColorUtil.fromHex("#461524")),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          image: DecorationImage(
            image: FileImage(File(_selectedAadhaarImage!.path)),
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
                  _selectedAadhaarImage = null;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Column(
      children: [
        Divider(
          color: ColorUtil.fromHex("#D4D4D4"),
          thickness: 1.5,
        ),
        const SizedBox(height: 5),
        SubmitSelectInputBorder(
          label: _emptyString,
          dropdownValue: _selectedCountryName,
          hint: "Country",
          listvalues: _countryNames,
          onChanged: _onCountryChanged,
        ),
        SubmitSelectInputBorder(
          label: _emptyString,
          dropdownValue: _selectedStateName,
          hint: "State",
          listvalues: _stateNames,
          onChanged: _onStateChanged,
        ),
        SubmitSelectInputBorder(
          label: _emptyString,
          dropdownValue: _selectedDistrictName,
          hint: "District",
          listvalues: _districtNames,
          onChanged: _onDistrictChanged,
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      children: [
        Divider(
          color: ColorUtil.fromHex("#D4D4D4"),
          thickness: 1.5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
          child: Messageview(
            controller: _addressController,
            height: _addressFieldHeight.toDouble(),
            label: "Address",
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: secondaryButton("Submit", _handleSubmitButtonPress),
      ),
    );
  }

  // Event Handlers
  void _onCountryChanged(String? selectedCountry) {
    setState(() {
      _selectedCountryName = selectedCountry;
      _selectedStateName = null;
      _selectedDistrictName = null;
      _stateNames.clear();
      _districtNames.clear();
    });
    
    if (selectedCountry != null) {
      final countryId = _countryIds.elementAt(_countryNames.indexOf(selectedCountry));
      _fetchStates(countryId.toString());
    }
  }
  void _onStateChanged(String? selectedState) {
    setState(() {
      _selectedStateName = selectedState;
      _selectedDistrictName = null;
      _districtNames.clear();
    });
    
    if (selectedState != null) {
      final stateId = _stateIds.elementAt(_stateNames.indexOf(selectedState));
      _fetchDistricts(stateId.toString());
    }
  }

  void _onDistrictChanged(String? selectedDistrict) {
    setState(() {
      _selectedDistrictName = selectedDistrict;
    });
  }

  void _handleSubmitButtonPress() {
    if (_validateForm()) {
      _submitRegistration();
    }
  }

  // Validation Methods
  bool _validateForm() {
    if (_isNameEmpty()) {
      showToast("Please enter name");
      return false;
    }
    
    if (_isPhoneEmpty()) {
      showToast("Please enter phone");
      return false;
    }
    
    if (_isAddressEmpty()) {
      showToast("Please enter your address");
      return false;
    }
    
    if (_selectedCountryName == null) {
      showToast("Please select country");
      return false;
    }
    
    if (_selectedStateName == null) {
      showToast("Please select state");
      return false;
    }
    
    if (_selectedDistrictName == null) {
      showToast("Please select district");
      return false;
    }
    
    return true;
  }

  bool _isNameEmpty() => _nameController.text.trim().isEmpty;
  bool _isPhoneEmpty() => _phoneController.text.trim().isEmpty;
  bool _isAddressEmpty() => _addressController.text.trim().isEmpty;

  // Data Initialization
  Future<void> _initializeAgentData() async {
    try {
      final String savedReferralId = await getSavedObject("referalId");
      final int savedBranchId = await getSavedObject("branch");

      print("Branch ID: $savedBranchId");
      
      if (savedReferralId.isNotEmpty) {
        _agentReferralId = savedReferralId;
      }
      
      if (savedBranchId > 0) {
        _branchId = savedBranchId;
        _fetchCountries(_branchId!);
      }
    } catch (e) {
      print("Error initializing agent data: $e");
    }
  }


  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1930, 8),
      lastDate: DateTime.now(),
    );
    
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _selectedDateOfBirth = pickedDate.toString().substring(0, 10);
        _dateOfBirthController.text = DateFormat(_dateFormat)
            .format(DateTime.parse(_selectedDateOfBirth!))
            .toString();
      });
    }
  }


  Future<void> _selectImageFromGallery() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      
      if (pickedFile != null) {
        setState(() {
          _selectedAadhaarImage = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }


  Future<void> _fetchCountries(int branchId) async {
    print("Fetching countries for branch: $branchId");
    _clearLocationData();

    try {
      Loading.show(context);
      final Countrymodel countryResponse = await Locationservice.getCountry(branchId);
      Loading.dismiss();
      
      setState(() {
        _countryNames = countryResponse.data.countryList
            .map((country) => country.countryName)
            .toList();
        _countryIds = countryResponse.data.countryList
            .map((country) => country.id)
            .toList();
      });
    } catch (error) {
      print("Error fetching countries: $error");
      Loading.dismiss();
    }
  }

  Future<void> _fetchStates(String countryId) async {
    _clearStateAndDistrictData();
    
    try {
      Loading.show(context);
      final Statemodel stateResponse = await Locationservice.getState(countryId);
      Loading.dismiss();
      
      setState(() {
        _stateNames = stateResponse.data.stateList
            .map((state) => state.stateName)
            .toList();
        _stateIds = stateResponse.data.stateList
            .map((state) => state.id)
            .toList();
      });
    } catch (error) {
      print("Error fetching states: $error");
      Loading.dismiss();
    }
  }

  Future<void> _fetchDistricts(String stateId) async {
    try {
      Loading.show(context);
      final Districtmodel districtResponse = await Locationservice.getDistrict(stateId);
      Loading.dismiss();
      
      setState(() {
        _districtNames = districtResponse.data.districtsList
            .map((district) => district.districtName)
            .toList();
        _districtIds = districtResponse.data.districtsList
            .map((district) => district.id)
            .toList();
      });
    } catch (error) {
      print("Error fetching districts: $error");
      Loading.dismiss();
    }
  }

  Future<void> _submitRegistration() async {
    try {
      final Map<String, dynamic> registrationData = _buildRegistrationData();
      
      print("Submitting registration: $registrationData");
      Loading.show(context);
      
   
          await Registrationservice.getagentRegistration(registrationData);
      
      Loading.dismiss();
      Navigator.pop(context, true);
    } catch (error) {
      print("Registration error: $error");
      Loading.dismiss();
    }
  }

  // Helper Methods
  void _clearLocationData() {
    _countryIds.clear();
    _countryNames.clear();
    _clearStateAndDistrictData();
  }

  void _clearStateAndDistrictData() {
    _stateNames.clear();
    _stateIds.clear();
    _districtNames.clear();
    _districtIds.clear();
  }

  Map<String, dynamic> _buildRegistrationData() {
    return {
      "name": _nameController.text.trim(),
      "email": _emailController.text.trim(),
      "phone": _selectedCountryCode + _phoneController.text.trim(),
      "pancard": _panCardController.text.trim(),
      "adhaarcard": _aadhaarController.text.trim(),
      "dob": _selectedDateOfBirth,
      "referalId": _agentReferralId,
      "address": _addressController.text.trim(),
      "nominee_relation": _nomineeRelationController.text.trim(),
      "nominee_phone": _nomineePhoneController.text.trim(),
      "nominee": _nomineeNameController.text.trim(),
      "district": _districtIds.elementAt(
        _districtNames.indexOf(_selectedDistrictName!),
      ),
      "branchId": _branchId,
      "adhar": _selectedAadhaarImage?.path,
      "state": _stateIds.elementAt(
        _stateNames.indexOf(_selectedStateName!),
      ),
      "country": _countryIds.elementAt(
        _countryNames.indexOf(_selectedCountryName!),
      ),
      "pincode": _pincodeController.text.trim(),
    };
  }

  bool validateMobile(String phoneNumber) {
    final RegExp phoneRegExp = RegExp(_phonePattern);
    
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

  