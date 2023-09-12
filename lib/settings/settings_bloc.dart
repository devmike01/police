import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/injector.dart';
import 'package:police/core/prefs.dart';
import 'package:police/settings/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState>{

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
    emit(SettingsState(crimeNotifEnabled: enabled,
        newsNotifEnabled: state.newsNotifEnabled));
  }

  void enableNewsNotification(bool enable){
    _appPrefs.setEnableNewsNotif(enable);
    emit(SettingsState(newsNotifEnabled: enable,
        crimeNotifEnabled: state.crimeNotifEnabled));
  }

  void openLicense(){
    // emit(OpenLicenceState());
  }
}