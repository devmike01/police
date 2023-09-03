import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:police/misc/app_icons.dart';

class ForcesBanner extends StatelessWidget{

  String bannerTitle;
  String bannerImage;

  ForcesBanner(this.bannerImage, this.bannerTitle, {super.key});

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
            children: [
              Expanded(child: Text(bannerTitle, style: Theme.of(context)
                  .textTheme.titleLarge?.copyWith(color: Colors.white),)),
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