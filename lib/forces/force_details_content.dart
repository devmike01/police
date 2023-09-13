import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:police/forces/force_details_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../misc/app_icons.dart';
import 'force_detail_card.dart';
import 'force_details_route.dart';

class ForceDetailsContent extends StatelessWidget{

  ForceDetailState state;

  ForceDetailsContent(this.state, {super.key});


  @override
  Widget build(BuildContext context) {

    final details = state.data;
    final socials = details?.engagementMethods;

    return CustomScrollView(
      slivers: [
        // Add the app bar to the CustomScrollView.
        SliverAppBar(
          snap: true,
          pinned: true,
    collapsedHeight: 140,
          title: Text(details?.name ??"", style: Theme
              .of(context).textTheme.titleLarge?.copyWith(fontSize: 20,
              fontWeight: FontWeight.w800, color: Colors.white),),
          floating: true,
          flexibleSpace: SizedBox(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(AppIcons.ukPolice,
                    fit: BoxFit.cover, height: 200,),),
                Container(
                  margin: EdgeInsets.only(top: 150),
                  child: Wrap(
                    children: [ForceDetailCard(title: 'Telephone',
                        subtitle: details?.telephone ??ForceDetailsRoute.notAvailable,
                        subTitleSize : 24, trailing: IconButton(onPressed: (){
                        launchUrl(Uri.parse('tel:${details?.telephone}'));
                      }, icon: const Icon(Icons.phone, color: Colors.white,)),)],
                  ),
                )
              ],
            ),
          ),
          expandedHeight: 250,
        ),
        // Next, create a SliverList
        SliverList.list(
          children: [
            ForceDetailCard(title: 'Description',
                subtitle: details?.description ??ForceDetailsRoute.notAvailable),
            const SizedBox(height: 5,),
            Column(
    children: socials?.map((e) => ForceDetailCard(title: socials?.first.title ??'',
    subtitle: socials.first.url ??ForceDetailsRoute.notAvailable)).toList() ??[],
    )

          ],
        ),
      ],
    );
  }

}