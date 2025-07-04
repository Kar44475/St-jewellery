class Chains {
  final String name;
  final double price;
  final String sku;
  final String description;
  final String image;
  final double weight;

  Chains(
      {required this.name,
      required this.price,
      required this.sku,
      required this.description,
      required this.weight,
      required this.image});
}

List<Chains> getChainData() {
  return [
    Chains(
        name: 'Classic Gold Chain',
        price: 18999.00,
        sku: 'CH-923417',
        description: 'Classic Gold Chain 22K CH-923417',
        weight: 4.3,
        image: "lib/ECommerceModule/Data/images/c1.jpg"),
    Chains(
        name: 'Graceful Beaded Chain',
        price: 21999.00,
        sku: 'CH-928235',
        description: 'Graceful Beaded Chain CH-928235',
        weight: 5,
        image: "lib/ECommerceModule/Data/images/c2.jpg"),
    Chains(
        name: 'Massive Loop Chains',
        price: 222346.00,
        sku: 'CH-928288',
        description: 'Massive Loop Chains 22K 928288',
        weight: 10,
        image: "lib/ECommerceModule/Data/images/c3.jpg"),
  ];
}
