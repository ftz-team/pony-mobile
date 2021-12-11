import 'package:flutter/cupertino.dart';

class UIColors {
  static Color background = new Color(0xff181820);
  static Color darkenBackground = new Color(0xff131319);
  static Color secondary = new Color(0xff343442);
  static Color cardBackground = new Color(0xff343442);
  static Color gray = new Color(0xff222222);
}

class UITextColors{
  static Color darked = new Color.fromARGB(60,255, 255, 255);
}

class UIGradients{
  static LinearGradient Main = LinearGradient(colors: [
    new Color(0xffFF00FF),
    new Color(0xffEC4B3C)
  ]);
}

class UIIcons{
  static String RegisterMain = "assets/register.png";
}

class UIIconColors{
  static Color disabled = new Color.fromARGB(70, 255, 255, 255);
  static Color active = new Color(0xffFF00FF);
}