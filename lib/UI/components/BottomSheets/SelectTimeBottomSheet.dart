import 'package:cached_network_image/cached_network_image.dart';
import 'package:cybergarden_app/UI/components/cards/AchivementCard.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/UI/containers/Wash/WashPage.dart';
import 'package:cybergarden_app/data/bloc/CollectorsBloc.dart';
import 'package:cybergarden_app/data/bloc/NavigationBloc.dart';
import 'package:cybergarden_app/data/bloc/WashesBloc.dart';
import 'package:cybergarden_app/data/models/AchivementModel.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:cybergarden_app/data/models/WashModel.dart';
import 'package:cybergarden_app/data/repository/collectorsApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cards/CollectorCard.dart';
import '../buttons.dart';

Widget SelectTimeBottomSheet(BuildContext context) {
  double height = displayHeight(context);

  return StreamBuilder(
      stream : washesBloc.activeFilters,
      builder:  (context, AsyncSnapshot<Map> snapshot){
        if (snapshot.hasData && snapshot.data!=null) {
          return Container(

            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: height * 0.3
              ),
              child: new Container(
                padding: EdgeInsets.only(top: 23, left: 15, right: 15),
                decoration: BoxDecoration(
                    color: UIColors.background,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0))),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultHeader("Сортировать по:", textAlign: TextAlign.left),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  color: snapshot.data!['sort'] == -1
                                      ? UIIconColors.active
                                      : Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(1000),
                                  )
                              ),
                              margin: EdgeInsets.only(
                                  right: 5
                              ),
                            ),
                            semiHeader("По умолчанию")
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          washesBloc.setSort(-1);
                        },
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      InkWell(
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  color: snapshot.data!['sort'] == 0
                                      ? UIIconColors.active
                                      : Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(1000),
                                  )
                              ),
                              margin: EdgeInsets.only(
                                  right: 5
                              ),
                            ),
                            semiHeader("Сначала дешевые")
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          washesBloc.setSort(0);
                        },
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      InkWell(
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  color: snapshot.data!['sort'] == 1
                                      ? UIIconColors.active
                                      : Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(1000),
                                  )
                              ),
                              margin: EdgeInsets.only(
                                  right: 5
                              ),
                            ),
                            semiHeader("Сначала дорогие")
                          ],
                        ),
                        onTap: () {
                          washesBloc.setSort(1);
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        washesBloc.updateFilters();
        return SizedBox();
      });
}

