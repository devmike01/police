import 'package:flutter/material.dart';
import 'package:police/misc/app_icons.dart';

class PageTitle extends StatelessWidget{
  String title;
  Function? onSettingsClicked;
  PageTitle(this.title, {super.key, this.onSettingsClicked});

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: const EdgeInsets.only(left: 20, right: 20,
        bottom: 20),
    duration: const Duration(milliseconds: 500),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: Text(
          title,
          maxLines: 2,
          softWrap: false,
          overflow: TextOverflow.fade,
          style:  const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        )),
        InkWell(
          onTap: (){
            onSettingsClicked?.call();
          },
          child: Image.asset(AppIcons.settingsIc,
            width: 40, height: 40, fit: BoxFit.fill,),
        )
      ],
    ),);
  }


}
