import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stjewellery/BottomNav/JewelleryTab.dart';
import 'package:stjewellery/BottomNav/contact.dart';
import 'package:stjewellery/BottomNav/gold_scheme.dart';
import 'package:stjewellery/BottomNav/stores.dart';
import 'package:stjewellery/screens/Notification/NotificationsScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:stjewellery/Drawer_Pages/drawer.dart';

class ModernHomeScreenState {
  static int selectedTabIndex = 0; // Default to Gold Booking tab
}
class ModernHomeScreen extends StatefulWidget {

  const ModernHomeScreen({Key? key}) : super(key: key);

  @override
  State<ModernHomeScreen> createState() => _ModernHomeScreenState();
}

class _ModernHomeScreenState extends State<ModernHomeScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
 // int _selectedTabIndex = 0;
   int _selectedTabIndex = ModernHomeScreenState.selectedTabIndex;
  CarouselSliderController _carouselController = CarouselSliderController();

  // YouTube Player Controller
  late YoutubePlayerController _youtubeController;
  bool _isPlayerReady = false;

  // YouTube URL
  final String _youtubeUrl = 'https://youtu.be/rWUOAXfEXvY';

  final List<String> _bannerImages = [
    'assets/pngIcons/1.jpg',
    'assets/pngIcons/2.jpg',
    'assets/pngIcons/3.jpg',
  ];

  final List<String> _bannerTexts = [
    'Discover the Best of Best',
    'Explore the Ultimate Design',
    'Crafted with Perfection',
  ];

  final List<Map<String, String>> _categories = [
    {'name': 'Chains', 'image': 'assets/pngIcons/chain22.png'},
    {'name': 'Necklace', 'image': 'assets/pngIcons/neck1.png'},
    {'name': 'Earrings', 'image': 'assets/pngIcons/earings.jpg.png'},
    {'name': 'Bangles', 'image': 'assets/pngIcons/bangles21.png'},
    {'name': 'Rings', 'image': 'assets/pngIcons/rings1.png'},
    {'name': 'Pendants', 'image': 'assets/pngIcons/pedants.jpg.png'},
  ];

  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Akhil',
      'review':
          'Amazing quality and beautiful designs. ST Jewellery never disappoints!',
      'rating': 5,
    },
    {
      'name': 'Priya',
      'review':
          'Excellent craftsmanship and customer service. Highly recommended!',
      'rating': 5,
    },
    {
      'name': 'Rajesh',
      'review': 'Best jewellery store in town. Quality is outstanding!',
      'rating': 5,
    },
    {
      'name': 'Meera',
      'review': 'Beautiful collection and fair pricing. Love shopping here!',
      'rating': 4,
    },
    {
      'name': 'Suresh',
      'review': 'Traditional designs with modern touch. Perfect combination!',
      'rating': 5,
    },
    {
      'name': 'Kavya',
      'review': 'Trustworthy and reliable. Been a customer for years!',
      'rating': 5,
    },
  ];

  final List<String> _tabTitles = [
    'Home',
    'About Us',
    'Jewellery',
    'Gold Booking',
    'Stores',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    _initializeYouTubePlayer();
  }

  void _showBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Drawer content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: DrawerWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initializeYouTubePlayer() {
    // Extract video ID from YouTube URL
    final videoId = YoutubePlayer.convertUrlToId(_youtubeUrl);

    if (videoId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false, // Changed to false to enable sound
          loop: true,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      );

      _youtubeController.addListener(() {
        if (_youtubeController.value.isReady && !_isPlayerReady) {
          setState(() {
            _isPlayerReady = true;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Image.asset("assets/pngIcons/mainIcons.png", height: 55),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _showBottomDrawer(context);
          },
        ),

          actions: [
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Notificationsscreen(),
            ),
          );
        },
        icon: const Icon(Icons.notifications, size: 25, color: Colors.white),
      ),
    ],
      ),
      body: Column(
        children: [
          // Modern Tab Bar - Fixed spacing and text cutting
          _buildModernTabBar(),
          // Content based on selected tab
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  // Fixed tab bar with proper spacing and text visibility
  Widget _buildModernTabBar() {
    return Container(
      height: 73, // Increased height to accommodate text properly
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10), // Added padding
        child: Row(
          children: List.generate(_tabTitles.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = index;
                  ModernHomeScreenState.selectedTabIndex = index;
                });
              },
              child: Container(
                // Fixed container sizing
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 15),
                constraints: BoxConstraints(
                  minWidth: 80, // Minimum width to prevent text cutting
                ),
                decoration: BoxDecoration(
                  color: _selectedTabIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _selectedTabIndex == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Center(
                  child: Text(
                    _tabTitles[index],
                    style: TextStyle(
                      color: _selectedTabIndex == index
                          ? Colors.white
                          : Colors.grey[700],
                      fontWeight: _selectedTabIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 13, // Slightly reduced font size for better fit
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return _buildAboutUsContent();
      case 2:
        return JewelleryTab();
      case 3:
        return GoldBookingTab();
      case 4:
        return StoresTab();
      case 5:
        return ContactTab();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Carousel
          _buildBannerCarousel(),
          SizedBox(height: 30),

          // Design Icon and Text Section
          _buildDesignSection(),
          SizedBox(height: 30),

          // Categories Grid
          _buildCategoriesGrid(),
          SizedBox(height: 40),

          // Video Section with YouTube Player - Removed extra play button
          _buildVideoSection(),
          SizedBox(height: 40),

          // Customer Reviews - Fixed shadow issue
          _buildCustomerReviews(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return Container(
      height: 250,
      child: CarouselSlider(
        carouselController: _carouselController,
        options: CarouselOptions(
          height: 250,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        items: _bannerImages.asMap().entries.map((entry) {
          int index = entry.key;
          String imagePath = entry.value;

          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey[600],
                            ),
                          );
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        left: 20,
                        right: 20,
                        child: Text(
                          _bannerTexts[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 3,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDesignSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // SVG Icon with error handling
          Image.asset(
            'assets/pngIcons/diamond.png',
            height: 80,
            width: 80,
            // placeholderBuilder: (context) => Container(
            //   height: 80,
            //   width: 80,
            //   decoration: BoxDecoration(
            //     color: Colors.grey[300],
            //     shape: BoxShape.circle,
            //   ),
            //   child: Icon(Icons.diamond, size: 40, color: Colors.grey[600]),
            // ),
          ),
          SizedBox(height: 20),

          // Title and Description
          Text(
            'Good Jewellery for Best Occasion',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          Text(
            'Designs so intricate seen before that you have never seen before',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        children: List.generate(_categories.length, (index) {
          // Create random heights for staggered effect
          double height = index % 3 == 0 ? 200 : (index % 2 == 0 ? 180 : 220);

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      _categories[index]['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: Colors.grey[600],
                          ),
                        );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        _categories[index]['name']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Updated video section - Removed extra play button, enabled sound
  Widget _buildVideoSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            'Cultivated from Pure Love',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),

          // YouTube Player Container
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: YoutubePlayer(
                controller: _youtubeController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Theme.of(context).primaryColor,
                topActions: <Widget>[
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      _youtubeController.metadata.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
                onReady: () {
                  setState(() {
                    _isPlayerReady = true;
                  });
                },
                onEnded: (data) {
                  // Handle video end if needed
                },
              ),
            ),
          ),
          SizedBox(height: 15),

          // Only "Open in YouTube" button - removed extra play button
          ElevatedButton.icon(
            onPressed: () => _launchYouTube(),
            icon: Icon(Icons.open_in_new),
            label: Text('Open in YouTube'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fixed customer reviews with proper shadow visibility
  Widget _buildCustomerReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'What Our Customers Say',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: 20),

        // Fixed container with proper padding to show shadows
        Container(
          height: 220, // Increased height to accommodate shadows
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ), // Added vertical padding
            itemCount: _reviews.length,
            itemBuilder: (context, index) {
              return Container(
                width: 280,
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                ), // Increased horizontal margin
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(
                        0.3,
                      ), // Increased opacity for better visibility
                      spreadRadius: 3, // Increased spread radius
                      blurRadius: 10, // Increased blur radius
                      offset: Offset(0, 5), // Adjusted offset
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            _reviews[index]['name'][0],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _reviews[index]['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Row(
                                children: List.generate(5, (starIndex) {
                                  return Icon(
                                    starIndex < _reviews[index]['rating']
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Color.fromRGBO(255, 197, 19, 1),
                                    size: 16,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Expanded(
                      child: Text(
                        _reviews[index]['review'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyContainer(String title) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, size: 80, color: Colors.grey[400]),
          SizedBox(height: 20),
          Text(
            '$title Content',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Coming Soon...',
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Future<void> _launchYouTube() async {
    try {
      final Uri youtubeUri = Uri.parse(_youtubeUrl);

      // Try to launch with external application first (YouTube app)
      if (await canLaunchUrl(youtubeUri)) {
        await launchUrl(youtubeUri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback to browser if YouTube app is not available
        await launchUrl(youtubeUri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      // Show error message if launch fails
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open YouTube video: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Widget _buildAboutUsContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image
          _buildAboutUsBanner(),

          // SVG Icon Section
          _buildAboutUsIcon(),

          // About Us Content with Images
          _buildAboutUsTextContent(),

          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildAboutUsBanner() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/pngIcons/aboutus.jpeg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey[600],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'About Us Banner',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Gradient overlay for better text readability
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                ),
              ),
            ),
            // Banner text
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Text(
                'About ST Jewellers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutUsIcon() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Center(
        child: SvgPicture.asset(
          'assets/pngIcons/0b813673-d5bd-4695-b802-13991c90ac65.svg',
          height: 100,
          width: 100,
          placeholderBuilder: (context) => Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.business, size: 50, color: Colors.grey[600]),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutUsTextContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About Us Title
          Text(
            'About Us',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 20),

          // Company Description
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Text(
              'ST Jewellers – Manufacturer, Wholesaler, Retailer based in Thrissur, Kerala, India.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 30),

          // Experience Badge
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                '30+ Years of Experience',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          SizedBox(height: 30),

          // First paragraph with model2.png
          _buildTextWithImage(
            'Inclined towards best quality, we ensure that the design, quality and finish of the ornaments remain are our highpoints. We are Manufacturer, Wholesaler, Retailer specialized in bulk sales of exclusive Gold Jewellery, Bridal Jewellery, Fine Jewellery.',
            'assets/pngIcons/model2.png',
            isImageLeft: true,
          ),

          SizedBox(height: 30),

          // Second paragraph with img2.png
          _buildTextWithImage(
            'We offer Bracelets, Necklace Set that are authentic and exhibit high quality. Our commitment to excellence has made us a trusted name in the jewellery industry.',
            'assets/pngIcons/img2.png',
            isImageLeft: false,
          ),

          SizedBox(height: 30),

          // Third paragraph with img1.png
          _buildTextWithImage(
            'We are traditional wholesaler and firmly believe to deliver optimum product quality at best competitive price. Our extensive collection caters to all your jewellery needs.',
            'assets/pngIcons/img3.png',
            isImageLeft: true,
          ),

          SizedBox(height: 40),

          // Call to Action Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.1),
                  Theme.of(context).primaryColor.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.diamond,
                  size: 50,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 15),
                Text(
                  'Experience the Difference',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Visit our store in Thrissur, Kerala and discover our exquisite collection of traditional and contemporary jewellery.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to contact or store location
                    setState(() {
                      _selectedTabIndex = 5; // Contact tab
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'Contact Us',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextWithImage(
    String text,
    String imagePath, {
    required bool isImageLeft,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          if (isImageLeft) ...[
            // Image first, then text
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.6,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.justify,
            ),
          ] else ...[
            // Text first, then image
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.6,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
