import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/settings/license_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/license.dart';




class LicenseRoute extends StatelessWidget{

  const LicenseRoute({super.key});

  static const String route = "/LicenseRoute";

  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (c) => LicenseCubit(c),
    child: BlocBuilder<LicenseCubit, String>(
      builder: (c, state){

        print("jsonResult001 => $state");

        if(state.isEmpty){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final controller = WebViewController()
          ..loadHtmlString(state);


        return Scaffold(
          appBar: AppBar(
            title: const Text("License"),
          ),
          body:  SafeArea(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: WebViewWidget(controller: controller,),
            ),
          ),
        );
      },
    ),);
  }

}