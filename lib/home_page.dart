import 'package:flutter/cupertino.dart';
import 'package:routing/tabs_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.news),
            label : 'Feeds'
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label : 'Search'
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label : 'Settings'
          ),
        ],
      ),
      tabBuilder: (context,index){
        switch(index){
          case 0 :
            return TabsPage(text : 'Feeds Page');
          case 1 :
            return TabsPage(text : 'Search Page');
          case 2 : 
            return TabsPage(text : 'Settings Page');
          default : 
            return Center(
              child: Text('Page not Found!'),
            );
        }
      },
    );
  }
}