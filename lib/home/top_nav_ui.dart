import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:police/home/top_nav.dart';

class TopNavBar extends StatefulWidget{

  List<TopNav> children;
  String selectedValue ='';
  Function(int)? onSelect;

  TopNavBar(this.children, {super.key, this.onSelect});

  @override
  TobNavState createState() => TobNavState();

}

class TobNavState extends State<TopNavBar>{

  int selected =0;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(right: 60, left: 20),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.children.map((e) {
          e.selected = e.index == selected;
          return Padding(
            padding: EdgeInsets.only(right: 30, bottom: 30),
            child: InkWell(
              onTap: (){
                widget.onSelect?.call(e.index);
                setState(() {
                  selected = e.index;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.title ?? "", style: Theme.of(context)
                      .textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),),
                  AnimatedOpacity(opacity: 0.1,
                    duration: Duration(milliseconds: 400),
                    child: e.selected ? buildBar() : null,
                  )
                ],
              ),
            ),);
        }).toList(),
      ),
    );
  }

  Widget buildBar(){
    return Container(
      height: 5,
      width: 20,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor
      ),
    );
  }

}