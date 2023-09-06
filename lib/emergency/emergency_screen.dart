import 'package:flutter/material.dart';
import 'package:police/misc/asset_manager.dart';
import 'package:police/misc/page_title.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/emergency_nums.dart';

class EmergencyScreen extends StatelessWidget{

  static String route = "emergency/EmergencyScreen";

  const EmergencyScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Back"),
      ),
      backgroundColor: Colors.grey.shade50,
      body: Container(

        padding: EdgeInsets.all(15),
      child: SafeArea(child: SingleChildScrollView(child: Column(
        children: [
          PageTitle("United Kingdom emergency\nnumbers", showSettings: false,),
          Expanded(
              flex: 0,
              child: FutureBuilder<List<EmergencyNum>>(builder: (context, snapshot){

            if(snapshot.data == null && snapshot.error ==null){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
                children: snapshot.data?.map((emergencyNum){
                  return Padding(padding: EdgeInsets.all(4), child:  InkWell(
                    onTap: (){
                      _makePhoneCall(emergencyNum.number);
                    },
                    child:  Card(
                      color: Colors.blueAccent,
                      child: Padding(padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.phone, color: Colors.redAccent,),
                            const SizedBox(width: 15,),
                            Expanded(child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(emergencyNum?.title ??"", textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                                Text(emergencyNum?.number ??"",
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme.titleMedium?.copyWith(color: Colors.white54,
                                        fontWeight: FontWeight.w900))
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),);
                }).toList() ??[]
            );

          /*    ListView
                .builder(itemBuilder: (context, index){
              final emergencyNum = snapshot.data?[index];
              return Card(
                color: Colors.blueAccent,
                child: Padding(padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.phone, color: Colors.redAccent,),
                      const SizedBox(width: 15,),
                      Expanded(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(emergencyNum?.title ??"", textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                          Text(emergencyNum?.number ??"",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme.titleMedium?.copyWith(color: Colors.white54,
                                  fontWeight: FontWeight.w900))
                        ],
                      ))
                    ],
                  ),
                ),
              );
            }, itemCount: snapshot.data?.length ?? 0,);*/
          }, future: AssetManager.getEmergencyNumbers(context),)

          )
        ],
      ))
      ),),
    );
  }


  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

}