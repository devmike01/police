import 'package:flutter/material.dart';
import 'package:police/exts/dynamic_ext.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'news_details_args.dart';

class NewsDetailsWebView extends StatelessWidget{

  const NewsDetailsWebView({super.key});

  static String route = "news/NewsDetailsWebView";

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings!.arguments.as<NewsDetailsArgs>();

    final controller = WebViewController()
       ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(args?.url ??""));
    return Scaffold(
      appBar: AppBar(title: Text(args?.title ??'')),
      body: WebViewWidget(controller: controller),
    );
  }

}