import 'package:police/core/injector.dart';
import 'package:police/core/news_api_client.dart';
import 'package:police/core/police_api_service.dart';
import 'package:police/core/prefs.dart';
import 'package:workmanager/workmanager.dart';

class NotificationWorker{
  static final prefs = getIt.get<AppPrefs>();
  static final newsApi = getIt.get<NewsApiClient>();
  static final crimeApi = getIt.get<PoliceApiClient>();

  @pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
  static void callbackDispatcher() async{
    final enableNewsNotif = await prefs.enableNewsNotif();

    Workmanager().executeTask((task, inputData) {

      if(task ==  "crime-notification"){
        if(enableNewsNotif) {
          newsApi.topHeadlines().then((value) {
            print("executeTask $value");
          }, onError: (e){
            print('callbackDispatcher => $e');
          });
        }else{
          Workmanager().cancelByTag("task-identifier-news");
        }
      }


      if(task ==  "news-notification"){
        callbackCrimeDispatcher(crimeApi);
      }


      return Future.value(true);
    });
  }
}


// Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackCrimeDispatcher(PoliceApiClient crimeApi) async{
  final prefs = getIt.get<AppPrefs>();
  final enableCrimeNotif = await prefs.enableCrimeNotif();

  if(enableCrimeNotif) {
    prefs.getLocationData().then((value) {
      final date = DateTime.now();
      crimeApi.getCrimes(
          "${date.year}-${date.month - 1}", value?.latitude ?? 0,
          value?.longitude ?? 0).then((value) {
        print("executeTask01 $value");
      });
    }, onError: (e){
      print('callbackCrimeDispatcher => $e');
    });
  }else{
    Workmanager().cancelByTag("task-identifier-crime");
  }
}

void initWorker() async{
  await Workmanager().initialize(
      NotificationWorker.callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );

}

void notificationForNews(){
  Workmanager().registerPeriodicTask("task-identifier-news",
      "news-notification",
      initialDelay: const Duration(seconds: 10));
}

void notificationForCrime(){
  Workmanager().registerPeriodicTask("task-identifier-crime",
      "crime-notification",
      initialDelay: const Duration(seconds: 10));
}