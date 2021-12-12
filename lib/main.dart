import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/containers/Splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_preview/device_preview.dart';
import 'UI/containers/Auth/RegisterPage.dart';
import 'UI/containers/LoadingScreen.dart';
import 'UI/containers/navigator.dart';
import 'data/repository/default.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: UIColors.background, // navigation bar color
    statusBarColor: UIColors.background, // status bar color
  ));
  final bool kReleaseMode = true;

  runApp(
      DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) =>MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wash',
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: UIColors.background,
        fontFamily: 'Gilroy',
        accentColor: UIIconColors.active
      ),
      home: MyHomePage(title: 'Wash'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool loading = true;
  bool logged = false;


  Future<bool> init() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = (prefs.getString('USER_TOKEN') ?? null);


    if (null == token){
      return false;
    }
    var res = await isTokenValid(token);
    if (!res){
      return false;
    }

    final storage = new FlutterSecureStorage();
    await storage.write(key: "USER_TOKEN", value: token);

    return true;
  }

  @override
  void initState(){

    super.initState();
    init().then((value) => this.setState(() {

      if (value){
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => AppNavigator()));
      }else{
        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => SplashPage()));
      }
    }));


  }

  @override
  Widget build(BuildContext context) {
    return SplashPage();
  }
}
