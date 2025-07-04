// Define the Banner model class
class Banner1 {
  final String imageUrl;

  Banner1({
    required this.imageUrl,
  });
}

// Sample data for the banners
List<Banner1> getBanners() {
  return [
    Banner1(
      imageUrl: 'lib/ECommerceModule/Data/images/b1.jpg',
    ),
    Banner1(
      imageUrl: 'lib/ECommerceModule/Data/images/b2.jpg',
    ),
    Banner1(
      imageUrl: 'lib/ECommerceModule/Data/images/b3.jpg',
    ),
  ];
}

class Banner2 {
  final String imageUrl;

  Banner2({
    required this.imageUrl,
  });
}

// Sample data for the banners
List<Banner2> getBanners2() {
  return [
    Banner2(
      imageUrl: 'lib/ECommerceModule/Data/images/b4.jpg',
    ),
    Banner2(
      imageUrl: 'lib/ECommerceModule/Data/images/b5.jpeg',
    ),
    Banner2(
      imageUrl: 'lib/ECommerceModule/Data/images/b6.jpg',
    ),
  ];
}
