import 'dart:async';

import 'package:cybergarden_app/UI/components/navigation.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/data/bloc/NavigationBloc.dart';
import 'package:cybergarden_app/data/enum/Pages.dart';
import 'package:flutter/material.dart';

import 'Courses/CoursesPage.dart';
import 'Home/HomePage.dart';
import 'Map/MapPage.dart';
import 'Profile/ProfilePage.dart';

class AppNavigator extends StatefulWidget {
  NavigatorState createState() => NavigatorState();
}


class NavigatorState extends State<AppNavigator> with TickerProviderStateMixin {

  late StreamSubscription _subscription;
  int active = 1;

  List<Widget> pages = [
    HomePage(),
    MapPage(),
    ProfilePage(),
    ProfilePage(),
    CoursesPage(),
  ];

    PageController navController = PageController(initialPage: 1);

    @override
    void initState(){
      _subscription = navigationBloc.tab.listen((data) {
        this.setState(() {
          active = data;
        });
        navController.jumpToPage(data);
      });
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    double width = displayWidth(context);
    return Scaffold(

      body: PageView(

        controller: navController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (int) {
          setState(() {
            active = int;
          });
        },
        children: pages,
      ),
      bottomNavigationBar: BottomAppBar(

        color: UIColors.background,
        child: Container(
          decoration: BoxDecoration(
            color: UIColors.background
          ),
          padding: EdgeInsets.only(
            top: 10,
            bottom: 5
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 2, bottom:2),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 4 ,
                  child:                     GestureDetector(
                    onTap: (){
                      navController.jumpToPage(0);
                    },
                    child: 0!=active?NavItem("assets/home.svg" ,):NavItem.active("assets/home.svg" , ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: displayWidth(context) * 0.175,
                    height: 60,
                    child: FloatingActionButton(
                      child: InkWell(
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: UIGradients.Main,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.map, size: 30,),
                        ),
                      ),
                      onPressed: (){
                        navController.jumpToPage(1);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 4 ,
                  child:                    GestureDetector(
                    onTap: (){
                      navController.jumpToPage(2);
                    },
                    child: 2!=active?NavItem("assets/profile.svg" , ):NavItem.active("assets/profile.svg" , ),
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}