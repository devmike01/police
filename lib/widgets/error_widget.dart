import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget{

  String errorMsg;
  Function()? onReload;

  AppErrorWidget(this.errorMsg, {super.key, this.onReload});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Text(errorMsg),
    ];

    if(onReload != null){
      children.add(
          TextButton(onPressed: onReload!,
              child: const Text("Reload")));
    }
    return Column(
      children: children,
    );
  }

}