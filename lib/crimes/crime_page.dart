import 'package:flutter/material.dart';
import 'package:police/misc/app_icons.dart';
import 'package:police/models/crime_at_location.dart';
import 'package:police/widgets/column_tile.dart';

import '../models/category_crime_by_location.dart';

class CrimePage extends StatefulWidget {

  List<CrimeAtLocation>? categoryCrimeByLocation;
  CrimePage(this.categoryCrimeByLocation, {super.key}){

  }

  @override
  CrimePageState createState() => CrimePageState();
}

class CrimePageState extends State<CrimePage>{

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: widget.categoryCrimeByLocation?.map((crime)
    => ColumnTile(crime?.location?.street?.name, crime?.month,
      AppIcons.arrest, onTap: (){
      }, horizontal: 0 /*trailing: Text("${crime.count}")*/,)).toList() ??[],
    );
  }

}