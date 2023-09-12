import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:police/core/app_navigator.dart';
import 'package:police/misc/app_icons.dart';
import 'package:police/models/live_news.dart';
import 'package:police/news/news_details_args.dart';

class NewsItem extends StatefulWidget{

  Articles articles;

  NewsItem(this.articles, {super.key});

  @override
  NewsItemState createState() {
    return NewsItemState();
  }

}

class NewsItemState extends State<NewsItem>{

  @override
  Widget build(BuildContext context) {
    final articles = widget.articles;
    return InkWell(
      onTap: (){
        context.router.pushNewsDetailsWebView(NewsDetailsArgs(articles.url ?? "",
            articles.title ?? ""));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(articles.title ??"", style: Theme.of(context).textTheme
              .titleSmall?.copyWith(fontWeight: FontWeight.w800)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(articles.author ?? "", style: Theme.of(context).textTheme
                  .titleSmall?.copyWith(fontSize: 11, color: Colors.grey),),
              Text(articles.publishedAt ??"", style: Theme.of(context).textTheme
                  .titleSmall?.copyWith(fontSize: 11, color: Colors.grey)),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 1, width: double.maxFinite,
            color: Colors.black.withAlpha(10),)
        ],
      ),
    );
  }

}