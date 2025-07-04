class ProductsModel {
  final String name;
  final double price;
  final String sku;
  final String description;
  final String image;
  final double weight;

  ProductsModel(
      {required this.name,
      required this.price,
      required this.sku,
      required this.description,
      required this.weight,
      required this.image});
}

List<ProductsModel> getProducts() {
  return [
    ProductsModel(
        name: 'Gold Ring',
        price: 16595.00,
        sku: 'SKCZLR16217',
        description: 'Gold Ring SKCZL217_22KT',
        weight: 4,
        image: "lib/ECommerceModule/Data/images/p1.png"),
    ProductsModel(
        name: 'Gold Pendant',
        price: 22346.00,
        sku: 'PDDZL41177',
        description: 'Gold Pendant PDDZL41177',
        weight: 12,
        image: "lib/ECommerceModule/Data/images/p2.png"),
    ProductsModel(
        name: 'Divine Gold Bangle',
        price: 222346.00,
        sku: 'BNCHT42832',
        description: 'Divine Gold Bangle BNCHT42832',
        weight: 20,
        image: "lib/ECommerceModule/Data/images/p3.png"),
    ProductsModel(
        name: 'Gold Jhumka Earring',
        price: 23751.00,
        sku: 'BNCHT42832',
        description: 'Gold Jhumka Earring ERTMN49839',
        weight: 8,
        image: "lib/ECommerceModule/Data/images/p4.png"),
    ProductsModel(
        name: '22 KT Three Tone Gold Studded Casual Ring',
        price: 26999.00,
        sku: 'ECRGM01020',
        description: '22 KT Three Tone Gold Studded Casual Ring ECRGM01020',
        weight: 6,
        image: "lib/ECommerceModule/Data/images/p5.png"),
    ProductsModel(
        name: 'ERA Uncut Diamond Nosepin ',
        price: 2199.00,
        sku: 'NPJUN10023',
        description: 'ERA Uncut Diamond Nosepin NPJUN10023',
        weight: 5,
        image: "lib/ECommerceModule/Data/images/p6.png"),
    ProductsModel(
        name: 'Gold Pendant ',
        price: 9899.00,
        sku: 'PDSGHTYA0029',
        description: 'Malanad Gold Pendant PDSGHTYA0029',
        weight: 6,
        image: "lib/ECommerceModule/Data/images/p7.png"),
    ProductsModel(
        name: '22 Karat Yellow Gold Floral Motif Finger Ring',
        price: 12999.00,
        sku: 'PDSGHTYA0029',
        description:
            'This eye-pleasing 22 Karat ring features a glossy yellow gold finish, enveloping blooming floral motif accented with leaf cutouts',
        weight: 6,
        image: "lib/ECommerceModule/Data/images/p8.png"),
  ];
}
