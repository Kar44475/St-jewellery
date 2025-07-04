import 'package:flutter/material.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/ECommerceModule/Data/OffersData.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    List<Offer> offers = getOffers();

    return Scaffold(
      appBar: AppBar(title: Text("Offers", style: appbarStyle)),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        separatorBuilder: (context, index) => h(10),
        itemCount: offers.length, // The number of offers
        itemBuilder: (context, index) {
          Offer offer = offers[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    offer.imageUrl,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      offer.description,
                      style: font(15, Colors.black, FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
