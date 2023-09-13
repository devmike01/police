import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForceDetailCard extends StatelessWidget{

  String title;

  String subtitle;

  double? subTitleSize;

  ForceDetailCard({super.key, required this.title, this.subTitleSize, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    child: Card(
      color: Colors.deepOrangeAccent,
      child:  Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme
                .bodySmall?.copyWith(color: Colors.white54)),
            Container(height: 1, color: Colors.grey.withAlpha(50),
              margin: const EdgeInsets.symmetric(vertical: 10),),
            Text(subtitle, style: Theme.of(context).textTheme
                .bodyMedium?.copyWith(color: Colors.white,
                fontSize: subTitleSize)?.copyWith(fontWeight: FontWeight.w800),)
          ],
        ),),
    ),);
  }

}