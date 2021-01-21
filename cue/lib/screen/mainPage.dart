import 'package:cue/screen/Cam/cue_ready.dart';
import 'package:cue/notification.dart';
import 'package:cue/screen/Search/search.dart';
import 'package:cue/screen/Subscribe/subscribe.dart';
import 'package:cue/screen/MyPage/mypage.dart';
import 'package:flutter/material.dart';
import 'package:cue/screen/VideoPlay/playlist.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;
  // static List<Widget> _widgetOptions = <Widget>[
  //   PlayListPage(),
  //   Container(
  //     child: Text('Search Page'),
  //   ),
  //   Container(),
  //   NotificationPage(),
  //   CueReady(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: IndexedStack(
      //   index: _selectedIndex,
      //   children: _widgetOptions,
      // ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: <Widget>[
            PlayListPage(),
            SearchPage(),
            // CloudStorageDemo(),
            SubscribePage(),
            NotificationPage(),
            MyPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        unselectedItemColor: Colors.black.withOpacity(.60),
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        elevation: 5.0,
        backgroundColor: Colors.white.withOpacity(.90),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: '홈',
            icon: ImageIcon(
              AssetImage('icons/홈.png'),
            ),
          ),
          BottomNavigationBarItem(
              label: '검색', icon: ImageIcon(AssetImage('icons/검색.png'))),
          BottomNavigationBarItem(
              label: '구독', icon: ImageIcon(AssetImage('icons/구독.png'))),
          BottomNavigationBarItem(
              label: '알림', icon: ImageIcon(AssetImage('icons/알림.png'))),
          BottomNavigationBarItem(
              label: '마이', icon: ImageIcon(AssetImage('icons/마이.png'))),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    });
  }
}
