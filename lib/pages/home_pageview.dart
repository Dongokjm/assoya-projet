import 'dart:collection';
import 'dart:convert' as convert;

import 'package:assoya/forms/driver_ride.dart';
import 'package:assoya/models/solde.dart';
import 'package:assoya/models/user_profile.dart';
import 'package:assoya/pages/map_page.dart';
import 'package:assoya/pages/route_list_page.dart';
import 'package:assoya/providers/auth_provider.dart';
import 'package:assoya/providers/data_provider.dart';
import 'package:assoya/widgets/drawer.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with SingleTickerProviderStateMixin {
  int bottomSelectedIndex = 1;
  DateTime? currentBackPressTime;
  ListQueue<int> _navigationQueue = ListQueue();
  TabController? tabController;
  PageController pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );
  void initState() {
    initData();
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
  }

  initData() async {
    var prefs = await SharedPreferences.getInstance();
    await Provider.of<DataProvider>(context, listen: false).fetchRides();
    await Provider.of<DataProvider>(context, listen: false).fetchCars();
    if (prefs.containsKey("auth_user")) {
      var user_data = convert.jsonDecode(prefs.getString("auth_user")!);
      Provider.of<AuthProvider>(context, listen: false).userProfile =
          UserProfile.fromJson(user_data);
      print(user_data);
    }
    if (prefs.containsKey("solde")) {
      var solde = convert.jsonDecode(prefs.getString("solde")!);
      Provider.of<AuthProvider>(context, listen: false).solde =
          Solde.fromJson(solde);
      print(solde);
    }
    // if (prefs.containsKey("token")) {
    //   await Provider.of<AuthProvider>(context, listen: false).getUserProfile();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Assoya",
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blue),
        ),
        drawer: const DrawerMenu(),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: PageView(
              controller: pageController,
              onPageChanged: (int index) {
                debugPrint("Index => ${index}");
                pageChanged(index);
              },
              children: [RouteListPage(), MapPage(), DriverRideForm()],
            )),
        bottomNavigationBar: ConvexAppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          activeColor: Colors.orange,
          color: Colors.blue,
          controller: tabController,
          items: [
            TabItem(icon: Icons.list, title: 'Trajets publiés'),
            TabItem(icon: Icons.map, title: 'Carte'),
            TabItem(icon: Icons.add, title: 'Ajouter Trajet'),
          ],
          initialActiveIndex: 1, //optional, default as 0
          onTap: (int i) {
            bottomTapped(i);
          },
        ));
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      _navigationQueue.addLast(index);

      pageController.jumpToPage(index);
      // pageController.animateToPage(index,
      //     duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void pageChanged(int index) {
    setState(() {
      _navigationQueue.addLast(index);
      bottomSelectedIndex = index;
      tabController!.animateTo(index);
    });
  }
}
