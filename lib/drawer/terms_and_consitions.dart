import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:stjewellery/Constant/constants.dart';

class TermsNconditions extends StatefulWidget {
  static String routeName = "/TermsNconditions";

  const TermsNconditions({Key? key}) : super(key: key);

  @override
  State<TermsNconditions> createState() => _TermsNconditionsState();
}

class _TermsNconditionsState extends State<TermsNconditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgClr,
      appBar: AppBar(title: Text("Terms & Conditions", style: appbarStyle)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Center(child: Image.asset("assets/logoOnly.png", height: 120)),
            Text("St jewellery", style: font(14, Colors.white, FontWeight.w700)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: item("TERMS & CONDITION")),
                      small(
                        "We know that you trust http://skygoldgroup.in/. This is the reason we have set high standards for our secured transactions and adherence to the customer information privacy. Please note that our privacy policy will be subject to changes at any point in time without any prior notice",
                      ),
                      const Divider(color: Colors.black54),
                      item(
                        "We request you to refer the below terms of our privacy policy",
                      ),
                      item("Personal information that is collected"),
                      small(
                        "We usually collect personal information like name, email id, contact number and such other details during the process of setting up an account with http://skygoldgroup.in/. When browsing a few sections of site without you being a registered member, you will not be able to place an order. We use your contact details so that we can intimate you about the timely offers, which are based on the previous orders and also depends on your interest",
                      ),
                      item("Use of information"),
                      small(
                        "We make use of the personal details for providing you with service requests. For various purposes like troubleshooting problems, collection of fees, for surveys and for providing information on various offers, we need your personal information. We also collect and analyze the demographic and profile data about users’ activity in our website. We make sure to identify and use the IP address for diagnosing problems in our website.",
                      ),
                      item("Security precautions"),
                      small(
                        "Our site is featured with strict security measures and due to this, we help in protecting the loss, alteration and misuse of information under our control. If in case you want to change your access of personal account information, we make sure to provide with secure server. Once the information is with us, we make sure to adhere to the stringent security guidelines and protect the same against unauthorized access",
                      ),
                      item("Choice/opt-out"),
                      small(
                        "http://skygoldgroup.in/ provides to all the users with a chance of opting out of promotional and marketing related services from us on behalf of our partners, after you set up an account.",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  item(String txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(txt, style: font(14, Colors.black, FontWeight.w700)),
    );
  }

  small(String txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(txt, style: font(12, Colors.black, FontWeight.w400)),
    );
  }
}
