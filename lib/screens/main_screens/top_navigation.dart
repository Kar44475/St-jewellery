import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stjewellery/screens/main_screens/paymen_history.dart';
import 'package:stjewellery/screens/main_screens/profile_screen.dart';
import 'package:stjewellery/screens/main_screens/scheme_screen.dart';
import 'package:stjewellery/screens/main_screens/jewellery_details_home_screen.dart'; // Add this import
import 'package:stjewellery/Constant/constants.dart';
import 'package:stjewellery/drawer/drawer.dart';
import 'package:stjewellery/Utils/utils.dart';
import 'package:stjewellery/screens/Notification/notifications_screen.dart';

class TopNavigation extends StatefulWidget {
  final int? initialTab;
  final String? sourceScreen;

  TopNavigation({Key? key, this.initialTab = 0, this.sourceScreen})
    : super(key: key);

  @override
  _TopNavigationState createState() => _TopNavigationState();
}

class _TopNavigationState extends State<TopNavigation>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  int? role;
  bool loading = false;

  // Animation controllers for smooth transitions
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Tab controller for top navigation
  late TabController _tabController;

  // Widget lists based on role
  final List<Widget> _widgetOptionsUser = <Widget>[
    const SchemeScreen(),
    const PaymentHistoryScreen(),
    const ProfileScreen(),
  ];

  final List<Widget> _widgetOptionsAgent = <Widget>[
    const SchemeScreen(),
    const PaymentHistoryScreen(),
    const ProfileScreen(),
  ];

  // Tab labels
  final List<String> _tabLabelsUser = ['Scheme', 'History', 'Profile'];
  final List<String> _tabLabelsAgent = ['Scheme', 'History', 'Profile'];

  // Tab icons
  final List<IconData> _tabIconsUser = [
    Icons.savings_outlined,
    Icons.history,
    Icons.person_outline,
  ];

  final List<IconData> _tabIconsAgent = [
    Icons.savings_outlined,
    Icons.history,
    Icons.person_outline,
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeTabController();
    _setInitialTab();

    Future.delayed(Duration.zero, () {
      getrole();
    });
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, -0.1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  void _initializeTabController() {
    _tabController = TabController(
      length: 3, // Profile, History, Scheme
      vsync: this,
      initialIndex: widget.initialTab ?? 0,
    );

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedIndex = _tabController.index;
        });
        HapticFeedback.lightImpact();
      }
    });
  }

  void _setInitialTab() {
    if (widget.initialTab != null) {
      _selectedIndex = widget.initialTab!;
    } else if (widget.sourceScreen == 'gold_scheme') {
      _selectedIndex = 0; // Scheme tab
    }
  }

  getrole() async {
    int? fetchedRole = await getSavedObject("roleid");
    setState(() {
      role = fetchedRole;
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // Handle back button press
  Future<bool> _onWillPop() async {
    // Navigate back to ModernHomeScreen with Gold Booking tab selected
    JewelleryDetailsHomeScreenState.selectedTabIndex = 3;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => JewelleryDetailsHomeScreen()),
    );
    return false; // Prevent default back behavior
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: role == null ? _buildLoadingWidget() : _buildTabContent(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _showBottomDrawer(context);
          },
        ),

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
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          JewelleryDetailsHomeScreenState.selectedTabIndex = 3;
          // Navigate back to ModernHomeScreen with Gold Booking tab selected
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => JewelleryDetailsHomeScreen(),
            ),
          );
        },
      ),
      title: Image.asset("assets/pngIcons/mainIcons.png", height: 40),
      centerTitle: true,
      bottom: _buildTabBar(),
    );
  }

  PreferredSizeWidget _buildTabBar() {
    List<String> tabLabels = _getTabLabels();
    List<IconData> tabIcons = _getTabIcons();

    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: SlideTransition(
          position: _slideAnimation,
          child: TabBar(
            controller: _tabController,
            indicatorColor: ColorUtil.fromHex("#FFDF85"),
            indicatorWeight: 3,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
            labelColor: ColorUtil.fromHex("#FFDF85"),
            unselectedLabelColor: Colors.white.withOpacity(0.7),
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            tabs: List.generate(tabLabels.length, (index) {
              return Tab(
                icon: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.all(_selectedIndex == index ? 8 : 6),
                  decoration: BoxDecoration(
                    color: _selectedIndex == index
                        ? Colors.white.withOpacity(0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    tabIcons[index],
                    size: _selectedIndex == index ? 22 : 20,
                  ),
                ),
                text: tabLabels[index],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
    );
  }

  Widget _buildTabContent() {
    List<Widget> widgetOptions = _getWidgetOptions();

    return FadeTransition(
      opacity: _fadeAnimation,
      child: TabBarView(
        controller: _tabController,
        physics: BouncingScrollPhysics(),
        children: widgetOptions.map((widget) {
          return Container(child: widget);
        }).toList(),
      ),
    );
  }

  // Helper methods to get appropriate data based on role
  List<String> _getTabLabels() {
    if (role == 2 || role == 4) {
      return _tabLabelsUser;
    } else {
      return _tabLabelsAgent;
    }
  }

  List<IconData> _getTabIcons() {
    if (role == 2 || role == 4) {
      return _tabIconsUser;
    } else {
      return _tabIconsAgent;
    }
  }

  List<Widget> _getWidgetOptions() {
    if (role == 2 || role == 4) {
      return _widgetOptionsUser;
    } else {
      return _widgetOptionsAgent;
    }
  }

  // Method to programmatically change tab (can be called from parent widgets)
  void changeTab(int index) {
    if (index >= 0 && index < _tabController.length) {
      _tabController.animateTo(index);
    }
  }

  // Method to get current tab index
  int getCurrentTab() {
    return _selectedIndex;
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
}
