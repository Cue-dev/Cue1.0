import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                elevation: 0,
                title: Text(
                  'Cue!',
                  style: Theme.of(context).textTheme.headline2,
                ),
                centerTitle: true,
                expandedHeight: 230.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 60, 40, 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).accentColor,
                          radius: 50,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              '나나 nana (23)',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              '연기 취미생',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('구독자 수 1,452'),
                            Text('게시물 3'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelStyle: Theme.of(context).textTheme.subtitle1,
                    labelColor: Colors.black,
                    indicatorColor: Theme.of(context).accentColor,
                    unselectedLabelColor: Theme.of(context).dividerColor,
                    tabs: [
                      Tab(text: "피드"),
                      Tab(text: "보관함"),
                      Tab(text: "스크랩"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[FeedTab(), StorageTab(), ScrapTab()],
          ),
        ),
      ),
    );
  }

  Widget FeedTab() {
    return Container(
      color: Colors.grey[100],
      child: GridView.builder(
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 2.0,
              child: Container(
                alignment: Alignment.center,
                child: Text('Item $index'),
              ),
            );
          }),
    );
  }

  Widget StorageTab() {
    return Container(
      color: Colors.grey[100],
    );
  }

  Widget ScrapTab() {
    return Container(
      color: Colors.grey[100],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
