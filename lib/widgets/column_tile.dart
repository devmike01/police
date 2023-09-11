import 'package:flutter/material.dart';

class ColumnTile extends StatelessWidget{

  String? title;
  String? subTitle;
  String? imagePath;
  Function()? onTap;
  double vertical;
  double horizontal;
  Widget? trailing;

  ColumnTile(this.title, this.subTitle,
      this.imagePath, {super.key, this.onTap,
        this.vertical = 10, this.horizontal =20,
        this.trailing});

  @override
  Widget build(BuildContext context) {
    final padding =EdgeInsets.symmetric(vertical: vertical,
        horizontal: horizontal);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Row(
                children:[
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: const BorderRadius.all(Radius.circular(40)),
                        border: Border.all(color: Theme.of(context).primaryColor, width: 2)
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Image.asset(imagePath ??"",
                        width: 40, height: 40, fit: BoxFit.cover,),
                    ),
                  ),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title ??"",
                        style: Theme.of(context).textTheme.titleSmall,),
                      Text(subTitle ??"",
                        style: Theme.of(context)
                            .textTheme.bodySmall
                            ?.copyWith(color: Colors.black45),)
                    ],
                  )),
                  SizedBox(
                    child: trailing,
                  )
                ]
            ),),
        ),
        Container(width: double.maxFinite, height: 1, color: Colors.black12,
          padding: padding,)
      ],
    );
  }

}