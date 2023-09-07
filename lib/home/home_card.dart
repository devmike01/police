import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget{
  late String title;
  late String image;
  late Function(int) onTap;
  int index;
  HomeCard({super.key, required this.title,
    required this.image, required this.onTap,
    required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap.call(index);
      },
      child: Column(
        children: [
          Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(title,
                  style: Theme.of(context)
                      .textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w900,
                      fontSize: 17, color: Colors.white),),
              )),
          Expanded(child: Image.asset(image,
            height: 100,  fit: BoxFit.cover, width: 100,))
        ],
      ),
    );
  }

}