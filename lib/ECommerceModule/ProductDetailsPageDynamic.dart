import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/Utils.dart';
import 'package:stjewellery/screens/Config/ApiConfig.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ProductDetailsEcomDynamic extends StatefulWidget {
  final Map data; // Accepting the data passed from the previous page

  const ProductDetailsEcomDynamic({Key? key, required this.data})
    : super(key: key);

  @override
  State<ProductDetailsEcomDynamic> createState() =>
      _ProductDetailsEcomDynamicState();
}

class _ProductDetailsEcomDynamicState extends State<ProductDetailsEcomDynamic> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var product = widget.data;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Offers",
          style: appbarStyle,
        ), // Display the product name in the app bar
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: ScreenSize.setHeight(context, 0.45),
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(ApiConfigs.imageurls + product["image"]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      product["productname"],
                      style: font(18, Colors.black, FontWeight.w600),
                    ),
                  ),
                  h(5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      product["producdescription"],
                      style: font(12, Colors.grey, FontWeight.w400),
                    ),
                  ),
                  h(10),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: Row(
                  //     children: [
                  //       Text("Weight : ${product.weight}g",
                  //           style: font(15, Colors.black, FontWeight.w500)),
                  //     ],
                  //   ),
                  // ),
                  h(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    // child: StarRating(),
                  ),
                  h(15),
                  // inStock(),
                  // head("Price Break-up"),
                  // priceBreakUp(),
                  // h(15),
                  // div,
                  h(15),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: Image.asset("assets/bis.jpeg"),
                  // ),
                  // h(15),
                  //
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 16),
                  //   child: Text(
                  //       "The BIS hallmark is an official certification that attests to the purity of gold, ensuring compliance with the quality standards prescribed by the Bureau of Indian Standards (BIS), the national standards body of India. Introduced in April 2000, this hallmark serves as a mark of authenticity for gold jewellery. It comprises the BIS logo, a three-digit number indicating the fineness of gold, the mark of the assaying and hallmarking centre, the jeweller’s identification mark or code, and a code denoting the year of hallmarking. The BIS hallmarking system holds a distinguished reputation across the Indian jewellery industry."),
                  // ),
                  // h(30),
                  // Image.asset("lib/ECommerceModule/Data/images/gridPrd.png"),
                  // h(15),
                  Container(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 15,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: contct(CupertinoIcons.phone, "Call us", () {
                              setState(() {
                                _makePhoneCall(
                                  'tel:'
                                  '$iosPhoneUser',
                                );
                              });
                            }),
                          ),
                          w(15),
                          Expanded(
                            child: contct(
                              FontAwesomeIcons.whatsapp,
                              "Chat with us",
                              () async {
                                var link = WhatsAppUnilink(
                                  phoneNumber: iosPhoneUser,
                                  text: "",
                                );
                                await launch('$link');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: bttn("Get Offer", () async {
            final link = WhatsAppUnilink(
              phoneNumber: iosPhoneUser,
              text:
                  "Hi, I would like to know more about this product \n ${product["productname"]}",
            );
            await launch('$link');
          }),
        ),
      ),
    );
  }

  // inStock() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Divider(color: Colors.grey[200], thickness: 10),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  //         child: Row(
  //           children: [
  //             const CircleAvatar(
  //               radius: 8,
  //               backgroundColor: Colors.green,
  //             ),
  //             w(10),
  //             Text(
  //               "In Stock",
  //               style: font(13, Colors.black, FontWeight.w600),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Divider(color: Colors.grey[200], thickness: 10),
  //     ],
  //   );
  // }

  head(txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Text(txt, style: font(16, Colors.black, FontWeight.w500)),
    );
  }

  TableRow _buildTableRow(String label, String value, {bool isBold = false}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  final div = const Divider(color: Color(0xffd8d6d6), thickness: 10);

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  contct(IconData icn, txt, GestureTapCallback tapp) {
    return GestureDetector(
      onTap: tapp,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          boxShadow: [shadow],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icn),
              w(10),
              Text(txt, style: font(14, Colors.black, FontWeight.w400)),
            ],
          ),
        ),
      ),
    );
  }
}
