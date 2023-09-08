import 'package:flutter/material.dart';

import 'crime_page.dart';

class CrimesTabs extends StatelessWidget{

  late List<CrimePage> items;

  CrimesTabs(this.items, {super.key});


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (pos){

            },
            tabs: items.map((tab) => Tab(text: tab.title,)).toList(),
          ),
          title: const Text('Tabs Demo'),
        ),
        body:  TabBarView(
          children: items.children,
        ),
      ),
    )
  }

}