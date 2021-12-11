import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/UI/containers/Auth/RegisterPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = displayHeight(context);
    return Scaffold(
      backgroundColor: UIColors.background,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15
        ),
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 5,
              child: Image.asset("assets/splash.png"),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  defaultHeader("Добро пожаловать!"),
                  Text(
                    "Все мойки твоего города в одном месте. Приложение позволяет записываться на мойку ко времени.",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, new CupertinoPageRoute(builder: (context) => RegisterPage()));
                },
                child: Image.asset("assets/go.png"),
              ),
            )

          ],
        ),
      ),
    );
  }
}