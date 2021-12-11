import 'package:cybergarden_app/UI/components/buttons.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/data/repository/authApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'RecieveCodePage.dart';

class RegisterPage extends StatefulWidget {
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {

  final NumberController = TextEditingController();

  final snackBar = SnackBar(
    content: Text('Проверьте правильность введенного номера.', style: TextStyle(color: Colors.white),), backgroundColor: UIColors.darkenBackground,
  );

  goNext(BuildContext context, int phone) async {
    var value = await sendCode(phone);
    if (value['ok']) {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => RecieveCodePage(
                phone: phone,
              )));
    }else{

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = displayWidth(context);
    double height = displayHeight(context);
    return Scaffold(
      backgroundColor: UIColors.background,
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(UIIcons.RegisterMain),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  defaultHeader("Вход по номеру"),
                  Container(
                    child: Text(
                      "Ваш номер будет использован для входа в аккаунт",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: UITextColors.darked,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 5
                    ),
                    width: width,
                    child: UnicornOutlineButton(
                        child: Container(
                          height: 60,
                          width: width*0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: Text(
                                      "+7",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                )
                              ),
                              Expanded(
                                flex: 1,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      width: 2,
                                      height: 100,
                                      color: UITextColors.darked,
                                    ),
                                  )

                              ),
                              Expanded(
                                flex: 9,
                                child:  Container(
                                  width: 100,
                                  child: new TextField(
                                    controller: NumberController,
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                        left: width*0.01,
                                      ),
                                      hintText: "Номер телефона",
                                      hintStyle:
                                      TextStyle(color: UITextColors.darked),
                                    ),
                                    style: TextStyle(
                                        color: Colors. white,
                                        fontSize: 18
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ], // Only numbers can be entered
                                    cursorColor: Colors.white,
                                  ),
                                ),
                              ),



                            ],
                          ),
                        ),
                        gradient: UIGradients.Main,
                        onPressed: () {},
                        radius: 15,
                        strokeWidth: 1),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 5
                    ),
                    width: width,
                    child: DefaultButton(

                        child: Text(
                          "Далее",
                          style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          goNext(context, int.parse(NumberController.text));
                        }),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
