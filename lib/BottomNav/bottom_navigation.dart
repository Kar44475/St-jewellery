import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:stjewellery/BottomNav/home_screen.dart';
import 'package:stjewellery/BottomNav/paymen_history.dart';
import 'package:stjewellery/BottomNav/products_screen.dart';
import 'package:stjewellery/BottomNav/profile_screen.dart';
import 'package:stjewellery/BottomNav/scheme_screen.dart';
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/Utils/Utils.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  static openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  int? role;

  // Animation controllers
  late AnimationController _bounceController;
  late AnimationController _rippleController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _rippleAnimation;

  getrole() async {
    int? fetchedRole = await getSavedObject("roleid");
    setState(() {
      role = fetchedRole;
    });
  }

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  bool _isVisible = true;
  bool loading = false;

  final List<Widget> _widgetOptionsUser = <Widget>[
    const HomeScreen(),
    const SchemeScreen(),
    const ProductsScreen(),
const PaymentHistoryScreen(),
    const ProfileScreen(),
  ];
  final List<Widget> _widgetOptionsAgent = <Widget>[
    const SchemeScreen(),
const PaymentHistoryScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    // Trigger bounce animation
    _bounceController.forward().then((_) {
      _bounceController.reverse();
    });
    
    // Trigger ripple animation
    _rippleController.forward().then((_) {
      _rippleController.reset();
    });

    setState(() {
      _selectedIndex = index;
    });
    
    // Haptic feedback
    HapticFeedback.lightImpact();
  }

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers
    _bounceController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    
    _rippleController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    
    // Initialize animations
    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeInOut,
    ));
    
    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: Curves.easeOut,
    ));
    
    Future.delayed(Duration.zero, () {
      getrole();
    });
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        drawerEdgeDragWidth: 0,
        key: _scaffoldKey,
        body: role == 2 || role == 4
            ? Stack(
                children: [
                  _widgetOptionsUser.elementAt(_selectedIndex),
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 20,
                    child: AnimatedBuilder(
                      animation: _bounceAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _bounceAnimation.value,
                          child: Container(
                            height: 68, // Same height as before
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildNavItem(0, Icons.home_outlined, "HOME"),
                                _buildNavItem(1, Icons.savings_outlined, "SCHEME"),
                                _buildNavItem(2, Icons.shopping_bag_outlined, "PRODUCT"),
                                _buildNavItem(3, Icons.history, "HISTORY"),
                                _buildNavItem(4, Icons.person_outline, "PROFILE"),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  _widgetOptionsAgent.elementAt(_selectedIndex),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 20,
                    child: AnimatedBuilder(
                      animation: _bounceAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _bounceAnimation.value,
                          child: Container(
                            height: 60, // Same height as before
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildNavItem(0, Icons.savings_outlined, "SCHEME"),
                                _buildNavItem(1, Icons.history, "HISTORY"),
                                _buildNavItem(2, Icons.person_outline, "PROFILE"),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: _rippleAnimation,
          builder: (context, child) {
            return Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Ripple effect
                  if (isSelected)
                    AnimatedBuilder(
                      animation: _rippleAnimation,
                      builder: (context, child) {
                        return Container(
                          width: 50 * _rippleAnimation.value,
                          height: 50 * _rippleAnimation.value,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1 * (1 - _rippleAnimation.value)),
                            shape: BoxShape.circle,
                          ),
                        );
                      },
                    ),
                  
                  // Main content
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon container with scale animation
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        width: isSelected ? 32 : 30,
                        height: isSelected ? 32 : 30,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: isSelected 
                            ? Colors.white.withOpacity(0.15)
                            : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: AnimatedScale(
                          scale: isSelected ? 1.1 : 1.0,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.elasticOut,
                          child: Icon(
                            icon,
                            size: 19,
                            color: isSelected 
                              ? ColorUtil.fromHex("#FFDF85")
                              : Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 3),
                      
                      // Animated text
                      AnimatedDefaultTextStyle(
                        duration: Duration(milliseconds: 200),
                        style: TextStyle(
                          color: isSelected 
                            ? const Color(0xffe8ad20)
                            : Colors.white,
                          fontSize: isSelected ? 9.5 : 9,
                          fontWeight: isSelected 
                            ? FontWeight.w900
                            : FontWeight.w600,
                        ),
                        child: Text(label),
                      ),
                      
                      // Selection indicator dot
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        width: isSelected ? 4 : 0,
                        height: isSelected ? 4 : 0,
                        margin: EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: ColorUtil.fromHex("#FFDF85"),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    if (role == 2 || role == 4) {
      HapticFeedback.mediumImpact();
      if (_selectedIndex != 0) {
        setState(() {
          _selectedIndex = 0;
        });
        return Future.value(false);
      } else {
        _showDialog();
        return Future.value(false);
      }
    }
    return Future.value(true);
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        title: const Text('Confirm Exit!'),
        titleTextStyle: const TextStyle(
          fontSize: 16,
          letterSpacing: 0.6,
          color: Color(0xff333333),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
        ),
        content: Text(
          'Are you sure you want to exit?',
          style: font(14, Colors.black, FontWeight.w400),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text('Yes', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
