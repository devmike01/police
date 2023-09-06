import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget{

  String errorMsg;
  Function onReloadPressed;

  ErrorScreen(this.errorMsg, this.onReloadPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(errorMsg),
          SizedBox(height: 20,),
          TextButton(onPressed: (){
            onReloadPressed.call();
          }, child: const Text("Reload"))
        ],
      ),
    );
  }

}