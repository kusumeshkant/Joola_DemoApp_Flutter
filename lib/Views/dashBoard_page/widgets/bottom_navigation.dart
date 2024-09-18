import 'package:flutter/material.dart';
import 'package:sampleapp/Views/dashBoard_page/dashboard_screen.dart';
import 'package:sampleapp/Views/explore_page/explore_page.dart';


class BottomNavBar extends StatefulWidget {
  final String? userName;

  const BottomNavBar({super.key, this.userName});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

   List<Widget> screens = <Widget>[
    
  ];

  @override
  void initState() {
    super.initState();
    screens = <Widget>[
    DashboardScreen(userName: widget.userName,),
    const ExplorePage(),
  ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        children: screens, // Disable swipe navigation
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rss_feed),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
         currentIndex: _selectedIndex,
        unselectedItemColor: Colors.purple.withOpacity(.3),
        selectedItemColor:Colors.purple[400],
        onTap: _onItemTapped,
      ),
    );
  }
}


