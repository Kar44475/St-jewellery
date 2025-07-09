import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoresTab extends StatefulWidget {
  const StoresTab({Key? key}) : super(key: key);

  @override
  State<StoresTab> createState() => _StoresTabState();
}

class _StoresTabState extends State<StoresTab> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final List<StoreInfo> stores = [
    StoreInfo(
      name: "ST Jewellers Thrissur",
      location: "Gate No.1, West Hill Road\nGosayikunnu, Thrissur - 680021",
      storeImage: "assets/pngIcons/tcr-str.png", // Restored individual image
      mapImage: "assets/pngIcons/thmap.jpeg",
      mapUrl: "https://maps.app.goo.gl/o9cQ8RuW8Y4LzEAcA?g_st=aw",
      phoneNumber: "+918589992077", // Add actual phone number
      isMainStore: true,
    ),
    StoreInfo(
      name: "ST Jewellers Vadakkancherry",
      location:
          "Golden Tower, Near Indian Bank\nOpp Private Bus Stand, Vadakkencherry\nKerala 678683", // Updated address
      storeImage: "assets/pngIcons/vdkn-tcr.png", // Restored individual image
      mapImage: "assets/pngIcons/vamap.jpeg",
      mapUrl: "https://maps.app.goo.gl/wRkpCwcayZ8W2dGs7?g_st=aw",
      phoneNumber: "+919544615319", // Add actual phone number
    ),
    StoreInfo(
      name: "ST Jewellers Ottappalam",
      location: "Palakkad - Ponnani Rd\nOttapalam, Kerala 679101",
      storeImage: "assets/pngIcons/st-otta.png", // Restored individual image
      mapImage: "assets/pngIcons/otmap.jpeg",
      mapUrl: "https://maps.app.goo.gl/JeZcqhtM92bgPvNk7?g_st=aw",
      phoneNumber: "+918606999852", // Add actual phone number
    ),
    StoreInfo(
      name: "ST Jewellers Kattappana",
      location: "Kattappana, Kerala 685508",
      storeImage:
          "assets/pngIcons/st-kattapana.png", // Restored individual image
      mapImage: "assets/pngIcons/ktmap.jpeg",
      mapUrl: "https://maps.app.goo.gl/9kRKA4Megd6Ajxm79?g_st=aw",
      phoneNumber: "+918606999828", // Add actual phone number
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(),

              SizedBox(height: 20),

              // Stores List
              _buildStoresList(),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            right: -50,
            top: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            left: -30,
            bottom: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.store, size: 40, color: Colors.white),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Our Stores',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Visit us at any of our ${stores.length} locations',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoresList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: stores.asMap().entries.map((entry) {
          int index = entry.key;
          StoreInfo store = entry.value;
          return AnimatedContainer(
            duration: Duration(milliseconds: 300 + (index * 100)),
            margin: EdgeInsets.only(bottom: 20),
            child: _buildStoreCard(store, index),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStoreCard(StoreInfo store, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Store Header with Image - Updated for long image
          _buildStoreHeader(store),

          // Store Details
          _buildStoreDetails(store),

          // Map Section
          _buildMapSection(store),

          // Action Buttons
          _buildActionButtons(store),
        ],
      ),
    );
  }

  Widget _buildStoreHeader(StoreInfo store) {
    return Container(
      height: 200, // Restored original height for individual store images
      width: double.infinity,
      child: Stack(
        children: [
          // Store Image - Back to individual images
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              store.storeImage,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover, // Works well with individual store images
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.7),
                        Theme.of(context).primaryColor.withOpacity(0.5),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.store, size: 60, color: Colors.white),
                        SizedBox(height: 10),
                        Text(
                          store.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Gradient Overlay
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              ),
            ),
          ),

          // Store Name and Badge
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    store.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                if (store.isMainStore)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Main Store',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreDetails(StoreInfo store) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      store.location,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection(StoreInfo store) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location Map',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () => _launchMap(store.mapUrl),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      store.mapImage,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.map,
                                  size: 40,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Map Preview',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Overlay with tap indicator
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.map,
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Tap to open in Maps',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(StoreInfo store) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _launchMap(store.mapUrl),
              icon: Icon(Icons.directions, size: 20),
              label: Text('Get Directions'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _callStore(store.phoneNumber),
              icon: Icon(Icons.phone, size: 20),
              label: Text('Call Store'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchMap(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar('Could not open maps application');
      }
    } catch (e) {
      print('Error launching map: $e');
      _showErrorSnackBar('Error opening maps: ${e.toString()}');
    }
  }

  // Fixed calling functionality
  Future<void> _callStore(String phoneNumber) async {
    try {
      // Remove any spaces or special characters except + and numbers
      String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

      // Ensure the number starts with tel:
      String telUrl = 'tel:$cleanNumber';

      print('Attempting to call: $telUrl'); // Debug log

      final Uri uri = Uri.parse(telUrl);

      // Check if the device can handle tel: URLs
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback: try with different approach
        await _tryAlternativeCall(cleanNumber);
      }
    } catch (e) {
      print('Error making phone call: $e');
      _showErrorSnackBar(
        'Unable to make phone call. Please dial manually: ${phoneNumber}',
      );
    }
  }

  // Alternative calling method
  Future<void> _tryAlternativeCall(String phoneNumber) async {
    try {
      // Try different URL schemes
      List<String> schemes = [
        'tel:$phoneNumber',
        'tel://$phoneNumber',
        'phone:$phoneNumber',
      ];

      bool callMade = false;
      for (String scheme in schemes) {
        try {
          final Uri uri = Uri.parse(scheme);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
            callMade = true;
            break;
          }
        } catch (e) {
          continue;
        }
      }

      if (!callMade) {
        _showCallDialog(phoneNumber);
      }
    } catch (e) {
      _showCallDialog(phoneNumber);
    }
  }

  // Show dialog with phone number if calling fails
  void _showCallDialog(String phoneNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.phone, color: Theme.of(context).primaryColor),
              SizedBox(width: 10),
              Text('Call Store'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please dial this number manually:'),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      phoneNumber,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Copy to clipboard if available
                _copyToClipboard(phoneNumber);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Text('Copy Number'),
            ),
          ],
        );
      },
    );
  }

  // Copy phone number to clipboard
  void _copyToClipboard(String phoneNumber) {
    // You'll need to add flutter/services import and use Clipboard.setData
    // For now, just show a message
    _showErrorSnackBar('Phone number: $phoneNumber');
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }
}

class StoreInfo {
  final String name;
  final String location;
  final String storeImage;
  final String mapImage;
  final String mapUrl;
  final String phoneNumber; // Added phone number field
  final bool isMainStore;

  StoreInfo({
    required this.name,
    required this.location,
    required this.storeImage,
    required this.mapImage,
    required this.mapUrl,
    required this.phoneNumber, // Required phone number
    this.isMainStore = false,
  });
}
