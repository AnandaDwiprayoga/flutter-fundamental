import 'package:flutter/cupertino.dart';
import 'package:routing/category_page.dart';

class TabsPage extends StatelessWidget {

  String text;

  TabsPage({@required this.text});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(text),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle),
            // anonymouse function for ternary condition
            (() {
              if(text == 'Feeds Page'){
                return CupertinoButton.filled(
                  child: Text('Select Category'), 
                  onPressed: (){
                    showCupertinoModalPopup(
                      context: context, 
                      builder: (context){
                        return CupertinoActionSheet(
                          title: Text('Select Categories'),
                          actions: [
                              CupertinoActionSheetAction(
                                onPressed: (){
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => CategoryPage(selectedCategory: "Technology") ));
                                }, 
                                child: Text('Technology')
                              ),
                              CupertinoActionSheetAction(
                                onPressed: (){
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => CategoryPage(selectedCategory: "Business") ));
                                }, 
                                child: Text('Business')
                              ),
                              CupertinoActionSheetAction(
                                onPressed: (){
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => CategoryPage(selectedCategory: "Sport") ));
                                }, 
                                child: Text('Sport')
                              ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Close')
                          ),
                        );
                      }
                    );
                  }
                );
              }else if(text == "Settings Page"){
                return CupertinoButton(
                  child: Text('Log out'), 
                  onPressed:(){
                    showCupertinoModalPopup(
                      context: context, 
                      builder: (context){
                        return CupertinoAlertDialog(
                          title: Text('Are you sure to log out ?'),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('No'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            CupertinoDialogAction(
                              child: Text('Yes'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      }
                    );
                  }
                );
              }
              // return empty view smallest
              return SizedBox.shrink();
            }())
          ]
        ),
      ),
    );
  }
}