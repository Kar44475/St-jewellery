import 'package:flutter/material.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "Contact Us",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Logo/Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.diamond,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "ST Jewellery",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Get in touch with us",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Contact Information Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 203, 3, 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.contact_support,
                      color: Colors.black87,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Contact Information",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Address Card
            _buildContactCard(
              icon: Icons.location_on,
              iconColor: Colors.red,
              title: "Our Address",
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ST Jewellery",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "13/1604 A, ST Jewellery,\nIritty, Keezhur\nKannur, Kerala 670703\nIndia",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              onTap: () => _openMaps(),
            ),

            SizedBox(height: 12),

            // Phone Card
            _buildContactCard(
              icon: Icons.phone,
              iconColor: Colors.green,
              title: "Phone Number",
              content: Text(
                "+91 90619 12916",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => _makePhoneCall("tel:+919061912916"),
            ),

            SizedBox(height: 12),

            // Email Card
            _buildContactCard(
              icon: Icons.email,
              iconColor: Colors.blue,
              title: "Email Address",
              content: Text(
                "info@stjewellery.com",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => _sendEmail("mailto:info@stjewellery.com"),
            ),

            SizedBox(height: 12),

            // Website Card
            _buildContactCard(
              icon: Icons.language,
              iconColor: Colors.purple,
              title: "Website",
              content: Text(
                "www.stjeweller.com",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => _openWebsite("https://www.stjeweller.com"),
            ),

            SizedBox(height: 24),

            // Quick Actions Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16),

                  Row(
                    children: [
                      // Call Button
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.phone,
                          label: "Call Now",
                          color: Colors.green,
                          onTap: () => _makePhoneCall("tel:+919061912916"),
                        ),
                      ),

                      SizedBox(width: 12),

                      // Email Button
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.email,
                          label: "Send Email",
                          color: Colors.blue,
                          onTap: () =>
                              _sendEmail("mailto:info@stjewellery.com"),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      // WhatsApp Button
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.chat,
                          label: "WhatsApp",
                          color: Color(0xFF25D366),
                          onTap: () => _openWhatsApp(),
                        ),
                      ),

                      SizedBox(width: 12),

                      // Website Button
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.language,
                          label: "Visit Website",
                          color: Colors.purple,
                          onTap: () =>
                              _openWebsite("https://www.stjeweller.com"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget content,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  content,
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Action Methods
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _sendEmail(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _openWebsite(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _openMaps() async {
    const url =
        'https://maps.google.com/?q=Iritty,+Keezhur,+Kannur,+Kerala+670703,+India';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _openWhatsApp() async {
    const url = 'https://wa.me/919061912916';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
