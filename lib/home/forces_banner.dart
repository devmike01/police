import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:police/misc/app_icons.dart';

class ForcesBanner extends StatelessWidget{

  String bannerTitle;
  String bannerImage;
  String bannerSubtitle;

  ForcesBanner(this.bannerImage, this.bannerTitle, this.bannerSubtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(padding: EdgeInsets.only(left: 20, right: 20),
      child: Card(
        color: Colors.orange,
        child: Padding(padding: EdgeInsets.only(left: 20, right: 30, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(bannerTitle, style: Theme.of(context)
                      .textTheme.titleLarge?.copyWith(color: Colors.white),),
                  Text(bannerSubtitle, style: Theme.of(context)
                      .textTheme.titleSmall?.copyWith(color: Colors.white60),)
                ],
              )),
              ClipRRect(
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10)),
                child: Image.asset(bannerImage, ),
              )
            ],
          ),),
      ),),
    );
  }

}