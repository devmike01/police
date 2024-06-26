import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/injector.dart';
import 'package:police/core/prefs.dart';
import 'package:police/core/workers/notification_worker.dart';
import 'package:police/models/license.dart';
import 'package:police/settings/settings_state.dart';

import '../core/news_api_client.dart';
import '../core/police_api_service.dart';

class SettingsCubit extends Cubit<SettingsState>{

  static final newsApi = getIt.get<NewsApiClient>();
  static final crimeApi = getIt.get<PoliceApiClient>();
  final _appPrefs = getIt.get<AppPrefs>();

  SettingsCubit(): super(SettingsState(loading: true)){
    _appPrefs.enableCrimeNotif().then((value){
      enableCrimeNotification(value);
    });

    _appPrefs.enableNewsNotif().then((value){
      enableNewsNotification(value);
    });
  }

  void enableCrimeNotification(bool enabled){
    _appPrefs.setEnableCrimeNotif(enabled);
    notificationForCrime(enabled);
    emit(SettingsState(crimeNotifEnabled: enabled,
        newsNotifEnabled: state.newsNotifEnabled));
  }

  void enableNewsNotification(bool enabled){
    _appPrefs.setEnableNewsNotif(enabled);

    notificationForNews(enabled);
    emit(SettingsState(newsNotifEnabled: enabled,
        crimeNotifEnabled: state.crimeNotifEnabled));
  }

  void openLicense(){
     emit(SettingsState(newsNotifEnabled: state.newsNotifEnabled,
         crimeNotifEnabled: state.crimeNotifEnabled,
         licenceState: OpenLicenceState()));
  }
}