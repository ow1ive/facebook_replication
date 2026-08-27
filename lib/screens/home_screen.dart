import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musca_mobprog/widgets/constants.dart';
import '../screens/newsfeed_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/profile_screen.dart';
import '../services/user_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final UserService _userService = UserService();

  String profileName = '';

  @override
  void initState() {
    super.initState();
    _loadProfileName();
  }

  Future<void> _loadProfileName() async {
    final user = await _userService.getSavedUser();
    if (!mounted || user == null) return;
    setState(() => profileName = user.fullName);
  }

  Widget _buildAppBarTitle() {
    if (_selectedIndex == 0) {
      return Image.asset(
        'assets/images/buddies.png',
        height: ScreenUtil().setHeight(40),
        fit: BoxFit.contain,
      );
    } else if (_selectedIndex == 1) {
      return Text(
        'Notifications',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(22),
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        profileName.isNotEmpty ? profileName : 'Olive Vergara Musca',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(22),
          color: const Color.fromARGB(255, 237, 132, 153),
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        title: _buildAppBarTitle(),
        actions: _selectedIndex == 2
            ? [
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.black),
                  onPressed: () => Navigator.pushNamed(context, '/settings'),
                ),
              ]
            : null,
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          NewsFeedScreen(),
          NotificationScreen(),
          ProfileScreen(),
        ],
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onTappedBar,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: FB_PRIMARY,
        currentIndex: _selectedIndex,
      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}
