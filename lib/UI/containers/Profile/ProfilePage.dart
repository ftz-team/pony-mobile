import 'package:cybergarden_app/UI/components/CurrentReservation.dart';
import 'package:cybergarden_app/UI/components/buttons.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/UI/containers/Splash.dart';
import 'package:cybergarden_app/data/repository/authApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AchievementsPage.dart';
import 'VisitedHistoryPage.dart';

class ProfilePage extends StatefulWidget {
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    double height = displayHeight(context);
    double width = displayWidth(context);
    return Scaffold(
        backgroundColor: UIColors.background,
        body: Container(
            width: width,
            height: height,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 20),
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Привет, водитель!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600)
                        ),
                        UnicornOutlineButton(
                            strokeWidth: 2,
                            radius: 15,
                            gradient: UIGradients.Main,
                            child: Container(
                              child: Text(
                                "Нужна помощь?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              padding: EdgeInsets.all(20),
                            ),
                            onPressed: () {}
                        )
                      ],
                    )),
                Container(
                  width: width,
                  height: 2,
                  decoration: BoxDecoration(
                    color: UIColors.secondary
                  ),
                  margin: EdgeInsets.only(
                    top: 15,
                    bottom: 15
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Тимофей Зайцев",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                      GestureDetector(
                        onTap: (){
                          logout();
                          Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => SplashPage()));
                        },
                        child: Text("Выйти",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      )
                    ],
                  ),
                ),

                Container(
                  width: width,
                  height: 2,
                  decoration: BoxDecoration(
                      color: UIColors.secondary
                  ),
                  margin: EdgeInsets.only(
                      top: 15,
                      bottom: 15
                  ),
                ),
                Container(
                  child: UnicornOutlineButton(
                    gradient: UIGradients.Main,
                    radius: 18,
                    strokeWidth: 1,
                    onPressed: () {  },
                    child:CurrentReservation(3,context),
                  ),
                ),
                menuItem(
                  context,
                  icon :Icons.settings_outlined,
                  text: "Настройки"
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, new CupertinoPageRoute(builder: (context)=>HitoryPage()));
                  },
                  child: menuItem(
                      context,
                      icon :Icons.history,
                      text: "История посещений"
                  ),
                ),
                GestureDetector(
                  child: menuItem(context, icon: Icons.loyalty, text: "Промокоды"),
                )

              ],
            )));
  }
}


Widget menuItem (BuildContext context, {required IconData icon,required String text}){
  return Container(
    margin: EdgeInsets.only(
      top: 10
    ),
      width: displayWidth(context),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: new Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          Expanded(
              flex: 7,
              child: Text(text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)))
        ],
      ));
}