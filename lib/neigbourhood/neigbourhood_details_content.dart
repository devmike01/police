import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/exts/buildcontext_ext.dart';
import 'package:police/forces/force_details_state.dart';
import 'package:police/neigbourhood/neigbourhood_detail_cubit.dart';
import 'package:police/widgets/error_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../forces/force_detail_card.dart';
import '../misc/app_icons.dart';
import 'neigbourhood_details_state.dart';

class NeigbourhoodDetailsContent extends StatelessWidget{

  static const String notAvailable = "Not Available";

  NeigbourhoodDetailsState state;

  NeigbourhoodDetailsContent(this.state, {super.key});


  @override
  Widget build(BuildContext context) {

    if(state.hasError){
      return AppErrorWidget(state.requiredMsg);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(state.openMapMsg !=null){
        context.showSnackbar(Text("${state.openMapMsg}"));
      }
    });

    final details = state.data;
    final contacts = details?.contactDetails;
    final location = details?.locations?.first;

    return CustomScrollView(
      slivers: [
        // Add the app bar to the CustomScrollView.
        SliverAppBar(
          snap: true,
          pinned: true,
          collapsedHeight: 140,
          title: Text(details?.name ??"", style: Theme
              .of(context).textTheme.titleLarge?.copyWith(fontSize: 20,
              fontWeight: FontWeight.w800),),
          floating: true,
          flexibleSpace: SizedBox(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Stack(
                    children: [
                      Image.asset(AppIcons.ukPolice,
                        fit: BoxFit.cover, height: 250, width: double.maxFinite,),
                      Container(
                        height: 250,
                        width: double.maxFinite,
                        color: Colors.white38,
                      )
                    ],
                  ),),
                Container(
                  margin: const EdgeInsets.only(top: 150),
                  child: Wrap(
                    children: [
                      ForceDetailCard(title: '${location?.address}. ${location?.postcode}',
                      subtitle: "${location?.name}",
                      subTitleSize : 24, trailing: IconButton(onPressed: (){
                        // Open map
                          context.read<NeigbourhoodDetailsCubit>()
                              .openMap("${location?.name}, ${location?.address}");
                        }, icon: const Icon(Icons.map, color: Colors.white,)),)],
                  ),
                )
              ],
            ),
          ),
          expandedHeight: 300,
        ),
        // Next, create a SliverList
        SliverList.list(
          children: [
            ForceDetailCard(title: 'Email',
                subtitle: contacts?.email ?? notAvailable),
            ForceDetailCard(title: 'Phone',
                subtitle: contacts?.telephone ?? notAvailable),
            ForceDetailCard(title: 'Description',
                subtitle: details?.description ?? notAvailable),
          ],
        ),
      ],
    );
  }

}