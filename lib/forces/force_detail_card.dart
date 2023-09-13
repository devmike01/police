import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceDetailCard extends StatelessWidget{

  String title;

  String subtitle;

  double? subTitleSize;

  Widget? trailing;

  ForceDetailCard({super.key, required this.title,
    this.subTitleSize, required this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    child: Card(
      color: Colors.redAccent,
      child:  Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme
                    .bodySmall?.copyWith(color: Colors.white70,
                    fontWeight: FontWeight.w800, ),
                overflow: TextOverflow.fade,
                    softWrap: false,
                    maxLines: 2),
                Container(height: 1, color: Colors.grey.withAlpha(50),
                  margin: const EdgeInsets.symmetric(vertical: 10),),
                Text(subtitle, style: Theme.of(context).textTheme
                    .bodyMedium?.copyWith(color: Colors.white,
                    fontSize: subTitleSize)?.copyWith(fontWeight: FontWeight.w800),)
              ],
            )),
            SizedBox(
              child: trailing,
            )
          ],
        ),),
    ),);
  }

}