class SilverOrnaments {
  final String name;
  final double price;
  final String sku;
  final String description;
  final String image;
  final double weight;

  SilverOrnaments(
      {required this.name,
      required this.price,
      required this.sku,
      required this.description,
      required this.weight,
      required this.image});
}

List<SilverOrnaments> getSilverData() {
  return [
    SilverOrnaments(
        name: 'Silver Precious Moment Ring',
        price: 1499.00,
        sku: 'CH-9234000',
        description:
            'This ring is the perfect accessory for the social butterfly. Live your life to the fullest and be ready to make a statement, wherever you go.',
        weight: 1.3,
        image: "lib/ECommerceModule/Data/images/s1.png"),
    SilverOrnaments(
        name: 'Silver Flowery Snowflake Studs',
        price: 1299.00,
        sku: 'CH-SI1532',
        description:
            'The first snowfall, the first kiss, and the first love are all very special. Add these earrings as a reminder of those beautiful memories.',
        weight: 1.5,
        image: "lib/ECommerceModule/Data/images/s2.png"),
    SilverOrnaments(
        name: 'Silver Star Constellation Necklace',
        price: 1799.00,
        sku: 'CH-925588',
        description:
            'The night sky devoid of any stars is unimaginable and incomplete. Likewise, your accessory collection, without this necklace, would be incomplete!',
        weight: 2,
        image: "lib/ECommerceModule/Data/images/s3.png"),
    SilverOrnaments(
        name: 'Anushka Sharma Silver Leaf Necklace',
        price: 2499.00,
        sku: 'CH-920976',
        description:
            'Feel the beautiful breeze with the rustle of the leaves filling the air. This necklace will make a memorable present for your dear ones.',
        weight: 3.5,
        image: "lib/ECommerceModule/Data/images/s4.png"),
    SilverOrnaments(
        name: 'Dual Tone United Hearts Anklet',
        price: 1899.00,
        sku: 'CH-920096',
        description:
            'Some trends are always a delight to wear. This will make a lovely gift for your sister.',
        weight: 3.5,
        image: "lib/ECommerceModule/Data/images/s5.png"),
  ];
}
