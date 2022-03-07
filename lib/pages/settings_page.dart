import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Paramètres"),
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: 'Vos préférences',
              tiles: [
                SettingsTile(
                  title: 'Language',
                  subtitle: 'English',
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Choisir votre devise',
                  subtitle: 'FCFA',
                  leading: Icon(Icons.attach_money),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: 'Activer les notifications',
                  leading: Icon(Icons.notification_important),
                  switchValue: true,
                  onToggle: (bool value) {},
                ),
              ],
            ),
          ],
        ));
  }
}
