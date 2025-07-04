import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatefulWidget {
  static String routeName = "/PrivacyPolicy";

  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Logo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.diamond,
                      size: 50,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Welcome to ST Jewellery",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Your trusted jewelry partner",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Content Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader("Privacy Policy"),
                    _buildContentText(
                      "We are confident that you have faith in us. We have set high standards to ensure that all the transactions in ST Jewellery are secured and protect the customer's personal information. Please note that the privacy policy will change at any time without any notice, and we recommend customers check our site occasionally to review the latest policy.",
                    ),
                    _buildSubHeader(
                      "We request our customer to go through the privacy policy terms as listed below:",
                    ),

                    _buildPolicySection(
                      "Gathered personal information",
                      "We gather our customers' personal data such as email, name, contact number, and other details to set up an account on ST Jewellery. You can browse through the section of our store, but you can only place the order if you are registered with us. We only use the contact information we provided to inform you about the offering in ST Jewellery across India based on previous orders and interests",
                    ),

                    _buildPolicySection(
                      "Use personal information",
                      "We use personal data to offer service requests. We also use the personal data to troubleshoot problems, collect survey fees, and provide information related to offers in ST Jewellery. We collect information about the demographics to understand the user activities on our website. We use the find out and the IP address to troubleshoot the problems with our website.",
                    ),

                    _buildPolicySection(
                      'Security measures',
                      "Our site follows stringent security measures to protect against the loss, change of information, or misuse of any information under our control. If you want to change your personal details, we provide you access to a highly secured server. Once the information is gathered, we abide by the security guidelines and protect your data against unauthorized access by hackers",
                    ),

                    _buildSectionHeader("TERMS & CONDITION"),
                    _buildContentText(
                      "We know that you trust www.stjeweller.com. This is the reason we have set high standards for our secured transactions and adherence to the customer information privacy. Please note that our privacy policy will be subject to changes at any point in time without any prior notice.",
                    ),

                    _buildSubHeader(
                      "We request you to refer the below terms of our privacy policy",
                    ),

                    _buildPolicySection(
                      "Personal information that is collected",
                      "We usually collect personal information like name, email id, contact number and such other details during the process of setting up an account with www.stjeweller.com. When browsing a few sections of site without you being a registered member, you will not be able to place an order. We use your contact details so that we can intimate you about the timely offers, which are based on the previous orders and also depends on your interest",
                    ),

                    _buildPolicySection(
                      "Use of information",
                      "We make use of the personal details for providing you with service requests. For various purposes like troubleshooting problems, collection of fees, for surveys and for providing information on various offers, we need your personal information. We also collect and analyze the demographic and profile data about users' activity in our website. We make sure to identify and use the IP address for diagnosing problems in our website",
                    ),

                    _buildPolicySection(
                      "Security precautions",
                      "Our site is featured with strict security measures and due to this, we help in protecting the loss, alteration and misuse of information under our control. If in case you want to change your access of personal account information, we make sure to provide with secure server. Once the information is with us, we make sure to adhere to the stringent security guidelines and protect the same against unauthorized access.",
                    ),

                    _buildPolicySection(
                      "Choice/opt-out",
                      "www.stjeweller.com provides to all the users with a chance of opting out of promotional and marketing related services from us on behalf of our partners, after you set up an account.",
                    ),

                    _buildSectionHeader("CANCELLATION & REFUND"),
                    _buildContentText(
                      "If there is any discrepancy, your orders will be cancelled. Sometimes, we cancel the product when the product is outside our inventory, or there is an error in the pricing details or product information. We hold every right to check extra information about our customers before accepting all their orders. We notify the customer immediately if the order is cancelled wholly or partially or if any extra information must be collected from the customer to accept the order. Customers can also cancel the order before it is dispatched from us. After we receive the cancellation request for the order, we initiate the refund process to send the amount through the same mode in which the payment was made within ten working days. If you cancel the product, the cancellation fee of around 2% will be charged to us, and the rest 98% will be refunded to your account. Your order for gold coins will not be allowed to cancel in any circumstance. We do not allow customers to cancel customized products or innovative buy products. In case the customer wants the money back or wants to exchange this product with the other one, then making charges along with the stone charges of the ordered product will be deducted. The rest of the payment will be made to customers within ten working days, or the amount will be adjusted based on the product with which it is exchanged. If the amount has been deducted from the customer's account and the transaction is failed, then the amount will be refunded to the customer's account within 72 hours. Once you place the order, it can be cancelled from your end before the product is dispatched. On receiving the cancellation request for ready for shipping product, we make sure to refund the amount through the same mode of payment within 10 working days. In case of cancellation pre-dispatch cancellation fees of 2% will be levied and balance 98% will be refunded back to the account. Gold coin order cancellation is not allowed under any circumstance. We don't accept cancellation for Smart Buy (make to order) or customized jewellery products. In case customer wants the money back or wants to exchange it with other product(s), making charges and stone charges of the ordered product will be deducted from the payment and balance will be refunded back to customer account within 10 working days or will be adjusted against the exchanged product(s). If in case the amount is deducted from customers account and the transaction has failed, the same will be refunded back to your account within 72 hours",
                    ),

                    _buildSectionHeader("SHIPPING POLICY"),
                    _buildPolicySection(
                      "Shipping & Delivery",
                      "Shipping order from ST Jewellery is highly secure and safe. Every product in our store is insured to ensure that it is covered for any damages that happen during the transit by the insurance company. For every package purchased at ST Jewellery, be it a gold coin or jewellery, we ship to your doorsteps in the best condition and without tampering the packing. We partner with reliable courier partners like Bluedart, Ecom Express, Amit, BVC, and Malca. We use the services of one of these shipping partners to ship the jewellery to the destined shipping address. Shipping and delivery days maximum 5 – 7 days.",
                    ),

                    _buildPolicySection(
                      "Charges to ship",
                      "We do not charge anything to ship the products within India. We deliver only to the ordered person. We want our customers to provide accurate details of the product's recipient. The person's name and address should be as in the ID proof issued by the Government of India. The recipient's name, address, landmark, pin code, and mobile number should be shown to the courier agent to make the delivery process hassle-free. When the product reaches the destination, the recipient should be ready with any of the following ID proofs to collect the product:",
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 203, 3, 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color.fromRGBO(255, 203, 3, 0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Required ID Proofs:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "• Passport\n• Pan card\n• Driving license\n• Voters ID",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    _buildContentText(
                      "We ensure that the product is delivered only through the courier agent and only after checking the ID proof of the person who will is collecting the parcel. The delivery will be complete once the courier agent checks the ID proof and confirms. To ensure the delivery is secure and safe, the agent will note the ID proof shown by the recipient. In this whole delivery process, the recipient must cooperate with the delivery agent by showing the original copy of their ID proof",
                    ),

                    _buildPolicySection(
                      "Delivery Location",
                      "We can deliver the consignment or order to the recipient's residential location or work location, or we can deliver it to our showrooms located in other places across India. We do not deliver the products to public places such as Malls, restaurants, the streets, hotels, or other places. If the recipient is unavailable at the time of delivery, our courier company will make three attempts to deliver the product. Still, if the recipient is unavailable at the delivery time, the product will be returned to our home branch.",
                    ),

                    _buildPolicySection(
                      "Change of shipping address",
                      "Customers can track the order status by logging into the website and navigating to the My Account section. Customers can change the shipping address. After ordering the product, customers can change the address where the product should be shipped. Customers can only change the shipping address until the product is out for delivery from the facility. In case customers want to change the shipping address after it is out of the facility, then they should send an email to info@stjewellery.com Product assurance will be based on the terms and conditions mentioned by the courier company. If there is any discrepancy in the details provided by the recipient, then the product won't be delivered. We have all rights to change the policy at any point in time without giving any prior notice. Changes in the policy will be published on the website immediately.",
                    ),

                    _buildPolicySection(
                      "Shipping issues",
                      "Once the order is received at your end, we want our customers to inspect the product to check its condition thoroughly. If any damage is found and happened during the shipment or suspect that some part of the product is lost, you can immediately contact our customer support team. You can ring us at this +91 90619 12916 or info@stjewellery.com us the issue to this email id. We suggest you report the issue within 72 hours of receiving the parcel",
                    ),

                    _buildPolicySection(
                      "Damaged products",
                      "If the parcel or product is damaged, you can contact our customer support center. You can either call or send an email. Our team responds briskly. Do not further damage the product or discard the packaging. Our team will investigate the issue once the email is received, and appropriate action will be taken if you report the problem within 72 hours of receiving the parcel. After this duration, we are not responsible for the refund of the damages. Your complaint will also be ignored.",
                    ),

                    _buildPolicySection(
                      "Missing products",
                      "We want our customers to thoroughly inspect the parcel and report the issues within 72 hours by contacting the customer care team through or info@stjewellery.com or +91 90619 12916. Our team will investigate the issue and develop the best resolution in 5 – 7 working days. We only entertain your complaint if you report the issue within this period or follow the inspection procedure as we suggested.",
                    ),

                    _buildPolicySection(
                      'Order not received',
                      "While dispatching, we have shared the tracking ID with your email address. Customers are responsible for tracking the parcel and checking the updates occasionally. Once the shipment is made, we will email your registered email address. If you have yet to collect the parcel physically and got an email about the delivery, you can contact our customer support team or email us immediately. We advise you to do this within 72 hours. Our team will investigate the issue and provide a resolution in 5 – 7 working days. However, your complaint will not be considered if you fail to report the issue within the given timeline. We will only be able to issue the refund if you have raised the chargebacks following the given process.",
                    ),

                    _buildSectionHeader("Refund Policy"),
                    _buildContentText(
                      "If the customer does not like the product, they can return it within 14 days from the delivery date. We ensure that the whole amount is refunded to the customer within 10 working days after the product is with us. The following are the terms applicable to customers to get the refund: If the product is not as shown on the website, the customer can return the product within 14 days. We will refund the amount within ten working days. There will be a registered address to which you must ship the product so that you will receive the refund. Refund facility can be availed only through this website, and customers cannot go to the other stores in India and ask for a refund. We will send you a return packaging kit in which you must package the product you want to return to us and handover this to the courier person. The reverse pick-up process will take 7 to 10 working days. You also have to make a note of the courier airway bill number. A refund will be initiated only after checking the quality of the product picked from you. Our quality assurance team will verify the product and complete its verification after collecting documents like insurance certificates, product certificates, and original invoices. Gold coins, silver articles, and they will be exempted from this 14-day refund policy. This is also not applicable for customized products, smart buy products, personalized ones, gift cards, and purchasing products made using promo codes or discount coupons.",
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Social Media Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Follow Us",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(
                        FontAwesomeIcons.instagram,
                        Color(0xFFE4405F),
                        () => _launchInstagram(),
                      ),
                      SizedBox(width: 20),
                      _buildSocialButton(
                        FontAwesomeIcons.facebook,
                        Color(0xFF1877F2),
                        () => _launchFb(),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "© ST Jewellery 2024",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 203, 3, 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSubHeader(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildContentText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildPolicySection(String title, String content) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }

  _launchInstagram() async {
    if (await canLaunch("https://www.instagram.com/stjewellery/")) {
      await launch("https://www.instagram.com/stjewellery/");
    } else {
      print("can't open Instagram");
    }
  }

  _launchFb() async {
    var url = "https://www.facebook.com/stjewelleryofficial/";
    if (await canLaunch(url)) {
      await launch(url, universalLinksOnly: true);
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }
}
