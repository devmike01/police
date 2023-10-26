import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StopSearchDetailItem extends StatelessWidget{

  IconData icon;

  String title;

  StopSearchDetailItem({super.key, required this.icon,
    required this.title, });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon),
            const SizedBox(width: 15,),
            Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyMedium,))
          ],
        ),
        Container(height: 1, color: Colors.grey.shade50,
          margin: const EdgeInsets.symmetric(vertical: 10),)
      ],
    );
  }
  
}