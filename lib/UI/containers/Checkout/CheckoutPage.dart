import 'package:cybergarden_app/UI/components/BottomSheets/CheckoutSheet.dart';
import 'package:cybergarden_app/UI/components/BottomSheets/CheckoutTypeSheet.dart';
import 'package:cybergarden_app/UI/components/BottomSheets/CollectorBottomSheet.dart';
import 'package:cybergarden_app/UI/components/buttons.dart';
import 'package:cybergarden_app/UI/components/cards/CollectorCard.dart';
import 'package:cybergarden_app/UI/components/cards/CollectorUpdated.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/data/bloc/CheckooutBloc.dart';
import 'package:cybergarden_app/data/bloc/CollectorsBloc.dart';
import 'package:cybergarden_app/data/bloc/NavigationBloc.dart';
import 'package:cybergarden_app/data/bloc/WashesBloc.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:cybergarden_app/data/models/WashModel.dart';
import 'package:cybergarden_app/data/repository/authApi.dart';
import 'package:cybergarden_app/data/repository/washesApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget{
  WashModel wash;
  CheckoutPage({required this.wash});
  CheckoutPageState createState()=> CheckoutPageState(wash: this.wash);
}

class CheckoutPageState extends State<CheckoutPage>{

  WashModel wash;
  CheckoutPageState({required this.wash});

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance!
        .addPostFrameCallback((_) => checkoutBloc.updateFilters());
  }
  @override
  Widget build(BuildContext context) {

    double height = displayHeight(context);
    double width = displayWidth(context);

    return Scaffold(
        backgroundColor: UIColors.darkenBackground,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor : UIColors.background,
          elevation: 0.0,
          title:Container(

            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children : [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: new Icon(
                      Icons.arrow_back,
                      color : UIIconColors.active,
                    ),
                  ),

                ]
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  width: width,
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15
                  ),
                  decoration: BoxDecoration(
                      color: UIColors.background,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      )
                  ),
                  child: defaultHeader(
                    "Запись на мойку ("+wash.name+")",
                  ),

                )
            ),
            Expanded(
              flex: 7,
              child: Container(
                  margin: EdgeInsets.only(
                      top: 20
                  ),
                  width : width,
                  height : height,
                  padding : EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  child : StreamBuilder(
                    stream : checkoutBloc.activeFilters,
                    builder: (context, AsyncSnapshot<Map> snapshot){
                      if (snapshot.data !=null && snapshot.hasData){
                        return ListView(
                          children: [
                            defaultHeader("Время записи:"),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    plainText(WashesBloc.timesHardCode[snapshot.data!['time']]),
                                    InkWell(
                                      onTap: (){
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(125.0),
                                            ),
                                            builder: (context) {
                                              return CheckoutSheet(context, wash.available_slots);
                                            });
                                      },
                                      child: Icon(
                                        Icons.settings,
                                        color: UIIconColors.active,
                                        size: 32,
                                      ),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color : UIColors.gray,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            defaultHeader("Услуги:"),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: UIColors.gray,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: snapshot.data!['type'] == 110 ? plainText("Любое время"): Column(
                                          children:[
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 15,
                                                    width: 15,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.all(Radius.circular(40))
                                                    ),

                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  plainText(   wash.services[snapshot.data!['type']]['type_name']+" ("+wash.services[snapshot.data!['type']]['price'].toString()+"₽)")
                                                ],

                                              ),
                                            )
                                          ]
                                      ),
                                    ),
                                    Expanded(
                                        child: Align(
                                          child: InkWell(
                                            onTap: (){
                                              showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(125.0),
                                                  ),
                                                  builder: (context) {
                                                    return CheckoutSheetType(context, wash.services);
                                                  });
                                            },
                                            child: Icon(
                                              Icons.add_road_sharp,
                                              color: UIIconColors.active,
                                              size: 32,
                                            ),
                                          ),
                                          alignment: Alignment.centerRight,
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            defaultHeader("Цена:"),
                            semiHeader(wash.services[snapshot.data!['type']]['price'].toString()+"₽", align: TextAlign.start),
                            Container(
                              height: 30,
                            ),
                            DefaultButton(
                                child: Text("Оплатить",
                                  style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () async{

                                  await createReservation(wash.id, snapshot.data!['time']);
                                  _showMyDialog(context);


                                }),
                          ],);
                      }else{
                        return Center(

                          child: Container(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: UIIconColors.active,
                            ),
                          ),
                        );
                      }
                    },
                  )
              ),
            )
          ],
        )
    );
  }
}

Future<void> _showMyDialog( context) async {
  Navigator.pop(context);
  return showDialog<void>(
    context: context, // user must tap button!
    builder: (BuildContext context) {
      return new AlertDialog(
          backgroundColor: UIColors.background,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
        content:  Container(
          height: 170,
          padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
      children: [
      defaultHeader("Спасибо!"),
        SizedBox(
          height:20,
        ),
        semiHeader("Мойка будет ожидать вас в указанное время. Вы всегда можете проверить детали в профиле.")
      ],
      ),
      ),
      );

    },
  );
}