class Offer {
  final String imageUrl; // Image URL or Asset path
  final String description; // Description of the offer

  Offer({
    required this.imageUrl,
    required this.description,
  });
}

List<Offer> getOffers() {
  return [
    Offer(
      imageUrl: 'lib/ECommerceModule/Data/images/o1.jpg',
      description: 'Check Out our new arrivals!',
    ),
    Offer(
      imageUrl: 'lib/ECommerceModule/Data/images/o2.jpg',
      description: '20% off on selected items!',
    ),
    Offer(
      imageUrl: 'lib/ECommerceModule/Data/images/o3.jpg',
      description: 'Light weight Jewellery Collections!',
    ),
    Offer(
      imageUrl: 'lib/ECommerceModule/Data/images/o4.jpg',
      description: 'Gift your loved ones!',
    ),
  ];
}
