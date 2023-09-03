import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget{
  late String title;
  late String image;
  HomeCard({super.key, required this.title,
    required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(10),
              child: Text(title,
                style: Theme.of(context)
                    .textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w900,
                    fontSize: 17),),
            )),
        Expanded(child: Image.asset(image,
          height: 100,  fit: BoxFit.cover,))
      ],
    );
  }

}