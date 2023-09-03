import 'package:flutter/cupertino.dart';

class HomeHrCard extends StatelessWidget{
  
  late String title;
  late String subtitle;
  
  HomeHrCard({super.key, required this.title,
    required this.subtitle});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        Image.asset("")
      ],
    );
  }

}