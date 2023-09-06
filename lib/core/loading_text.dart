import 'package:flutter/material.dart';

class LoadingText extends StatefulWidget{
  String? title;
  TextStyle? style;
  double? width;

  LoadingText(this.title, {super.key, this.style, this.width});

  @override
  LoadingTextState createState() => LoadingTextState();

}

class LoadingTextState extends State<LoadingText> with SingleTickerProviderStateMixin{

  int opacity =1;


  @override
  Widget build(BuildContext context) {
    final title = widget.title;


    return title == null ? Container(
      height: 15,
      width: widget.width,
      color: Colors.white54,
      margin: const EdgeInsets.only(bottom: 10),
    ) : Text(title, style: widget.style,);
  }

}