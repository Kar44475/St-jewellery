import 'package:flutter/material.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/ECommerceModule/Data/silverData.dart';
import 'package:stjewellery/ECommerceModule/ProductDetailsPage.dart';
import 'package:stjewellery/Utils/starRating.dart';

class ExpandedSilver extends StatefulWidget {
  final txt;
  final data;
  const ExpandedSilver({Key? key, this.txt, this.data}) : super(key: key);

  @override
  State<ExpandedSilver> createState() => _ExpandedSilverState();
}

class _ExpandedSilverState extends State<ExpandedSilver> {
  @override
  Widget build(BuildContext context) {
    final List<SilverOrnaments> Chain = getSilverData();

    return Scaffold(
      appBar: AppBar(elevation: 1, title: Text(widget.txt, style: appbarStyle)),
      body: widget.data == "no"
          ? Center(
              child: Image.asset("lib/ECommerceModule/Data/images/noPrd.jpg"),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth =
                      (constraints.maxWidth) / 2; // Adjust for crossAxisSpacing
                  final itemHeight = itemWidth * 1.4;
                  final imgHeight =
                      itemWidth * 0.85; // Adjust the aspect ratio as needed
                  final aspectRatio = itemWidth / itemHeight;

                  return GridView.builder(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 0.0,
                      childAspectRatio: aspectRatio,
                    ),
                    itemCount: Chain.length, // Example number of items
                    itemBuilder: (context, index) {
                      final product = Chain[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsEcom(data: Chain[index]),
                            ),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black12,
                                width: 2,
                              ),
                              left: BorderSide(color: Colors.black12),
                              right: BorderSide(color: Colors.black12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                          imgHeight, // Set height based on calculated itemHeight
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(product.image),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        product.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: font(
                                          12,
                                          Colors.black,
                                          FontWeight.w500,
                                        ),
                                      ),
                                      h(5),
                                      Text(
                                        product.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: font(
                                          10,
                                          const Color(0xff787272),
                                          FontWeight.w400,
                                        ),
                                      ),
                                      h(5),
                                      // Text(
                                      //   rs + product.price.toString(),
                                      //   style: font(12, Colors.black,
                                      //       FontWeight.w600),
                                      // ),
                                      // h(3),
                                      StarRating(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
