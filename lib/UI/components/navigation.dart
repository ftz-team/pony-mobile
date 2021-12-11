import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavItem extends StatelessWidget{

  bool active;
  String asset;

  NavItem.active(this.asset):
      active = true;

  NavItem(this.asset):
      active = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(

          asset,
        color: active ? UIIconColors.active : UIIconColors.disabled,
        width: 50,
      ),
    );
  }
}