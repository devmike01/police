import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:police/core/injector.dart';
import 'package:police/core/news_api_client.dart';
import 'package:police/core/police_api_service.dart';
import 'package:police/core/prefs.dart';
import 'package:police/core/workers/received_notification.dart';
import 'package:police/repository/police_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:workmanager/workmanager.dart';

import '../../repository/news_repo.dart';

class NotificationWorker{
  //BuildContext context;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


  NotificationWorker(){
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse,
    );

    _requestPermissions();
    _isAndroidPermissionGranted();
  }


  void showNotification(String title,
      String subTitle,int id) async{
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
      icon: "ic_notification",
        priority: Priority.high,
        ticker: 'ticker',);

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        id, title, subTitle, notificationDetails,
        payload: 'item x');

  }


  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
  }

  static  StreamController<bool> _notificationsEnabled = StreamController.broadcast();

  void onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title ??""),
    //     content: Text(body ??''),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           // await Navigator.push(
    //           //   context,
    //           //   MaterialPageRoute(
    //           //     builder: (context) ,
    //           //   ),
    //           // );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled() ??
          false;

      _notificationsEnabled.sink.add(granted);
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
      await androidImplementation?.requestPermission();
      _notificationsEnabled.sink.add(grantedNotificationPermission ?? false);
    }
  }

}


void initWorker() async{
  await Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );

}



/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
StreamController<ReceivedNotification>.broadcast();


// Mandatory if the App is obfuscated or using Flutter 3.1+

void callbackCrimeDispatcher(PoliceApiClient crimeApi) async{
  final prefs = getIt.get<AppPrefs>();
  final enableCrimeNotif = await prefs.enableCrimeNotif();

  if(enableCrimeNotif) {
    prefs.getLocationData().then((value) async{
      final date = DateTime.now();
      final crimes = await crimeApi.getCrimes(
          "${date.year}-${date.month - 1}", value?.latitude ?? 0,
          value?.longitude ?? 0).then((value) {
        print("crimes +====> $value");
        _configureDidReceiveLocalNotificationSubject();
      });
    }, onError: (e){
      print('callbackCrimeDispatcher => $e');
    });
  }else{
    Workmanager().cancelByTag("task-identifier-crime");
  }
}



void _configureDidReceiveLocalNotificationSubject() {
didReceiveLocalNotificationStream.stream
    .listen((ReceivedNotification receivedNotification) async {
print("NOTIFICATION: ${receivedNotification.title}");
});
}

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher(){

  Workmanager().executeTask((task, inputData){
    //notifStream.sink.add('New Message was fired');
    Runner().computeAPI(inputData?['isCrime']);
    print('callbackCrimeDispatcher => $inputData => Hello');
    return Future.value(true);
  });
}

void notificationForNews(bool enable){
  if(!enable){
    Workmanager().cancelByUniqueName('task-identifier-news');
    return;
  }
  Workmanager().registerPeriodicTask("task-identifier-news",
      "news-notification",
      inputData: {
        'isCrime': false
      },
      frequency: const Duration(hours: 6),
      initialDelay: const Duration(seconds: 10));
}

void notificationForCrime(bool enable){
  if(!enable){
    Workmanager().cancelByUniqueName('task-identifier-crime');
    return;
  }
  Workmanager().registerPeriodicTask("task-identifier-crime",
      "crime-notification",
      inputData: {
        'isCrime': false
      },
      frequency: const Duration(hours: 6),
      initialDelay: const Duration(seconds: 10)
  );
}


class Runner{

  Runner(){
    registerStorage();
  }

  void computeAPI(bool isCrime){
    compute(runInBackground, isCrime);
  }

   void runInBackground(bool isCrime){
    NotificationWorker worker = NotificationWorker();
     final appPrefs = getIt.get<AppPrefs>();

    print('[WorkManager] => Hello: $isCrime');

     if(isCrime){
       registerPoliceAPI();
       _runCrime(worker, appPrefs);
     }else{
       registerNetworkAPI();
       _runNewsHeadLines(worker, appPrefs);
     }

     print('callbackCrimeDispatcher@ => ---- => Hell2o1');

  }

  void _runCrime(NotificationWorker worker,
      AppPrefs appPrefs) async{
    final crimeRepo = getIt.get<PoliceRepository>();
    final position = await appPrefs.getLocationData();

    final dateTime = DateTime.now();

    final date = dateTime.year-dateTime.month < 2 ? dateTime.month : 1;

    final crimes = await crimeRepo
        .crimeAtLocation(date.toString(), position?.latitude ??0,
        position?.longitude ??0);
    if(crimes.data != null){
      final crimeWithPos = crimes.data?.sublist(0, 2);
      crimeWithPos?.forEach((element) {

        worker.showNotification(element.location?.street?.name ??'',
            element.category ??'Not available', element.id ??0);
      });
    }
  }

  void _runNewsHeadLines(NotificationWorker worker,
      AppPrefs appPrefs){
    final repo = getIt.get<NewsRepository>();
    repo.getTopHeadlines().then((value) async{
      final oldTime = await appPrefs.getOldNewsTime();
      print('runInBackground ===> $oldTime');
      final liveArticles = value.data?.articles;
      liveArticles?.removeWhere((element) {
        int timeInMillis = DateTime
            .parse(element.publishedAt ??"").millisecondsSinceEpoch;
        bool isNewNews = timeInMillis > oldTime;
        print('runInBackground ===> ${element.publishedAt}');
        appPrefs.setOldNews(timeInMillis).then((value){
          print('runInBackground: SAVED ===> $timeInMillis : $value');
        });
        return isNewNews;
      });

      int id = 0;
      liveArticles?.forEach((element) {
        id += 1;
        worker.showNotification(element.title ?? "Unavailable Title",
            element?.source?.name ??"N/A", id);
        print('callbackCrimeDispatcher@ => ---- => ${element.title}');
      });
      //liveNews.articles.first;
    });
  }


}