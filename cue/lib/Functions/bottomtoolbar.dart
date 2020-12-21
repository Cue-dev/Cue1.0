import 'package:flutter/material.dart';

class BottomToolbar extends StatelessWidget {
  static const double NavigationIconSize = 20.0;
  static const double CreateButtonWidth = 38.0;

  final Function deleteHistory;

  BottomToolbar(this.deleteHistory);

  Widget get customCreateIcon => Container(
      width: 45.0,
      height: 27.0,
      child: Stack(children: [
        Container(
            margin: EdgeInsets.only(left: 10.0),
            width: CreateButtonWidth,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 45, 108),
                borderRadius: BorderRadius.circular(7.0))),
        Container(
            margin: EdgeInsets.only(right: 10.0),
            width: CreateButtonWidth,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 32, 211, 234),
                borderRadius: BorderRadius.circular(7.0))),
        Center(
            child: Container(
          height: double.infinity,
          width: CreateButtonWidth,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(7.0)),
          child: Icon(
            Icons.add,
            size: 20.0,
          ),
        )),
      ]));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MenuButton(
                'Home',
                Icon(Icons.home,
                    color: Colors.white, size: NavigationIconSize)),
            MenuButton(
                'Search',
                Icon(Icons.search,
                    color: Colors.white, size: NavigationIconSize)),
            MenuButton(
                'Home',
                Icon(Icons.add_circle,
                    color: Colors.white, size: NavigationIconSize)),
            MenuButton(
                'Messages',
                Icon(Icons.notifications,
                    color: Colors.white, size: NavigationIconSize)),
            MenuButton(
                'Profile',
                Icon(Icons.person,
                    color: Colors.white, size: NavigationIconSize))
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget MenuButton(String text, Widget icon) {
    return GestureDetector(
        onTap: () => {deleteHistory()},
        child: Column(
          children: <Widget>[
            icon,
            SizedBox(
              height: 7,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 11.0),
            )
          ],
        ));
  }
}
