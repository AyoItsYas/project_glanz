import 'package:flutter/material.dart';
import '../features/closet-page/page.dart';
import '../main-screen.dart';
import '../features/quick-match/page.dart';
import '../features/laundry/page.dart';

class CustomNavigator extends StatefulWidget {
  const CustomNavigator({super.key});

  @override
  State<CustomNavigator> createState() => _CustomNavigatorState();
}

class _CustomNavigatorState extends State<CustomNavigator> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MainView(),
    ClosetView(),
    QuickMatchView(),
    LaundryView(),
    Center(child: Text('Settings Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(), // Disable swipe to prevent manual page changes
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Stack(
          children: [
            // Animated circle background
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: _selectedIndex * (MediaQuery.of(context).size.width / 5),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                height: 50,
                child: Center(
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            // Navigation items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_outlined, 0),
                _buildNavItem(Icons.storage_outlined, 1),
                _buildNavItem(Icons.checkroom_outlined, 2),
                _buildNavItem(Icons.local_laundry_service_outlined, 3),
                _buildNavItem(Icons.settings_outlined, 4),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = index == _selectedIndex;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: SizedBox(
        width: 50,
        height: 50,
        child: Icon(
          icon,
          size: 32,
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}