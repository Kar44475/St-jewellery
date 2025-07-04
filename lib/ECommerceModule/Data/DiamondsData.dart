class Diamonds {
  final String name;
  final double price;
  final String sku;
  final String description;
  final String image;
  final double weight;

  Diamonds(
      {required this.name,
      required this.price,
      required this.sku,
      required this.description,
      required this.weight,
      required this.image});
}

List<Diamonds> getDiamondsData() {
  return [
    Diamonds(
        name: 'Made With 14K Gold And Lab-Grown Diamonds',
        price: 26999.00,
        sku: 'CH-929007',
        description:
            "Like a flower that never gives up till it blooms in full, let these earrings remind you to be a non-stop achiever who'll become a great sparkle someday.",
        weight: 3,
        image: "lib/ECommerceModule/Data/images/d1.jpg"),
    Diamonds(
        name: 'CYMARA DIAMOND SINLE HOOK PENDANT',
        price: 18799.00,
        sku: 'CH-DJ09112',
        description: 'Graceful Beaded Chain CH-928235',
        weight: 3,
        image: "lib/ECommerceModule/Data/images/d2.jpg"),
    Diamonds(
        name: 'Luxe Curves Diamond Bangle',
        price: 222346.00,
        sku: 'CH-9254678',
        description:
            'Sparkle brighter with this 18 Karat rose gold real Diamond Bangle. Its cluster setting of real diamonds exudes timeless elegance.',
        weight: 10,
        image: "lib/ECommerceModule/Data/images/d3.jpg"),
    Diamonds(
        name: 'Lucky Clover Diamond Pendant and Earrings set for Kids',
        price: 37899.00,
        sku: 'CH-LH87290',
        description:
            'Gift a touch of luck and sparkle with this 18 Karat yellow gold Pendant and Earrings set for kids, featuring dazzling Diamond clovers that twinkle with every move.',
        weight: 10,
        image: "lib/ECommerceModule/Data/images/d4.jpg"),
  ];
}
