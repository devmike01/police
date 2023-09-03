import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget{
  String title;
  PageTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(left: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:  TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20
          ),
        ),
        const SizedBox(height: 20,)
      ],
    ),);
  }


}
