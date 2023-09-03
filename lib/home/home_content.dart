import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/home/top_nav_ui.dart';
import 'package:police/misc/app_icons.dart';

import '../misc/page_title.dart';
import 'forces_banner.dart';
import 'home_card.dart';
import 'home_content_bloc.dart';
import 'top_bar_state.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final contentBloc = context.read<HomeContentBloc>();
    contentBloc.changePage(0);

    return BlocBuilder<HomeContentBloc, TopBarState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageTitle(state.title),
          TopNavBar(
            contentBloc.topBarNavItems,
            onSelect: (index) {
              contentBloc.changePage(index);
            },
          ),
          ForcesBanner(
            AppIcons.policeman_ic,
            "34 Isambard brunnel road",
          ),
          Expanded(
            child: Padding(padding: const EdgeInsets.all(20),
            child: state.homeMenus != null
                ? StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 25,
              crossAxisSpacing: 25,
              children: state.homeMenus?.map((e) {
                contentBloc.menuPos += 1;
                final homeMenu = (e as ForcesMenu);
                return StaggeredGridTile.extent(
                    crossAxisCellCount: 1,
                    mainAxisExtent: contentBloc.menuPos % 2 > 0 ? 190 : 230,
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: HomeCard(
                          title: homeMenu.title,
                          image: homeMenu.imgResPath),
                    ));
              }).toList() ?? [],
            )
                : Container(),)
          )
        ],
      );
    });
  }
}

/*
MasonryGridView.count(
  crossAxisCount: 4,
  mainAxisSpacing: 4,
  crossAxisSpacing: 4,
  itemBuilder: (context, index) {
    return Tile(
      index: index,
      extent: (index % 5 + 1) * 100,
    );
  },
);


Card(
                        margin: EdgeInsets.zero,
                        child: HomeCard(
                            title: homeMenu.title, image: homeMenu.imgResPath),
                      )
 */