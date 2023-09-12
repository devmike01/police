class SettingsState{
  bool crimeNotifEnabled;
  bool newsNotifEnabled;
  bool loading;

  SettingsState({this.crimeNotifEnabled =false,
    this.newsNotifEnabled =false, this.loading=false});

  SettingsState copy({bool? crimeNotifEnabled, bool? newsNotifEnabled}){
    if((newsNotifEnabled != this.newsNotifEnabled)
        && newsNotifEnabled != null){
      this.newsNotifEnabled = newsNotifEnabled;
    }
    if((crimeNotifEnabled != this.crimeNotifEnabled)
        && crimeNotifEnabled != null){
      this.crimeNotifEnabled = crimeNotifEnabled;
    }
    return this;
  }
}
// class CrimeState extends SettingsState{
//   @override
//   bool enable = false;
//
//   CrimeState(this.enable);
//
// }
//
// class NewsState extends SettingsState{
//
//   @override
//   bool enable;
//
//   NewsState(this.enable);
//
// }
//
// class OpenLicenceState extends SettingsState{
//   @override
//   bool enable =false;
//
//   OpenLicenceState();
//
// }
//
// class NoneState extends SettingsState{
//
//   @override
//   bool enable;
//
//   NoneState(this.enable);
//
// }