import 'package:assoya/forms/user_docs.dart';
import 'package:assoya/forms/user_preferences.dart';
import 'package:assoya/forms/user_profile.dart';
import 'package:assoya/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "${Provider.of<AuthProvider>(context, listen: false).userProfile!.name} ${Provider.of<AuthProvider>(context, listen: false).userProfile!.lastName}",
              style: TextStyle(color: Colors.blue),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.blue),
            bottom: TabBar(
              labelColor: Colors.blue,
              indicatorColor: Colors.orange,
              tabs: [
                Tab(
                  text: "Profile",
                ),
                Tab(
                  text: "Documents",
                ),
                Tab(
                  text: "Préférences",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              UserProfileForm(),
              UserDocsForm(),
              UserPreferencesForm(),
            ],
          ),
        ));
  }
}
