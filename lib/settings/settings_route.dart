import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/app_navigator.dart';
import 'package:police/settings/settings_bloc.dart';
import 'package:police/settings/settings_state.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsRoute extends StatefulWidget{

  static String route = "settings/SettingsRoute";

  const SettingsRoute({super.key});

  @override
  SettingsRouteState createState() {
    return SettingsRouteState();
  }

}

class SettingsRouteState extends State<SettingsRoute>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: BlocProvider(
        create: (_) => SettingsCubit(),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (BuildContext context, state) {

            if(state.loading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            print("new_state: $state");
            if(state.licenceState is OpenLicenceState){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                context.router.pushLicenseRoute();
              });
            }

            return SettingsList(
              sections: [
                SettingsSection(
                  title: const Text('Notifications'),
                  tiles: <SettingsTile>[
                    SettingsTile.switchTile(
                      onToggle: (value) {
                        context.read<SettingsCubit>()
                            .enableCrimeNotification(value);
                      },
                      initialValue: state.crimeNotifEnabled,
                      leading: const Icon(Icons.circle_notifications_outlined),
                      title: const Text('Crime'),
                    ),
                    SettingsTile.switchTile(
                      onToggle: (value) {
                        context.read<SettingsCubit>()
                            .enableNewsNotification(value);
                      },
                      initialValue: state.newsNotifEnabled,
                      leading: const Icon(Icons.notifications_active_outlined),
                      title: const Text('News'),
                    ),
                  ],
                ),
                SettingsSection(
                  title: const Text('Miscellaneous'),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      leading: const Icon(Icons.abc_outlined),
                      title: const Text('Licence'),
                      value: const Text('Licence for icons and illustrations used'),
                      onPressed: (_){
                        context.read<SettingsCubit>()
                            .openLicense();
                      },
                    ),
                    SettingsTile.navigation(
                      leading: const Icon(Icons.abc_outlined),
                      title: const Text('About'),
                      value: const Text('About '),
                      onPressed: (_){
                        context.read<SettingsCubit>()
                            .openLicense();
                      },
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

}