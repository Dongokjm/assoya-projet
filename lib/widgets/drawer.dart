import 'package:assoya/models/user_profile.dart';
import 'package:assoya/providers/auth_provider.dart';
import 'package:assoya/widgets/drawer_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Positioned.fill(
                    //     child: Container(
                    //   color: Colors.white,
                    // )),
                    Positioned.fill(
                        child: ListView(
                      // shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2.3,
                          child: DrawerHeader(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(Icons.arrow_back_ios)),
                                    Text(
                                      "Profile",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        splashRadius: 20,
                                        splashColor: Colors.red.shade400,
                                        color: Colors.red.shade300,
                                        highlightColor: Colors.red.shade300,
                                        onPressed: () async {
                                          var prefs = await SharedPreferences
                                              .getInstance();
                                          prefs.remove("token");
                                          prefs.remove("auth_user");
                                          Get.toNamed("/splash");
                                        },
                                        icon: Icon(
                                          Icons.logout_outlined,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: AssetImage(
                                                  "assets/images/user_avatar.png"))),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${provider.userProfile!.name!.toUpperCase()}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          "${provider.userProfile!.lastName}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Get.toNamed("/user_profile_page");
                                            },
                                            child: Text(
                                              "Modifier",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DrawerCard(
                                      title: "9800",
                                      pressed: () async {
                                        await Get.toNamed("/points");
                                      },
                                      icon: Icons.speed_outlined,
                                      subtitle: "points",
                                    ),
                                    DrawerCard(
                                      title: "5",
                                      pressed: () {
                                        Get.toNamed("/race_list_page");
                                      },
                                      icon: Icons.alt_route_sharp,
                                      subtitle: "courses",
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.car_rental),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: const Text(
                            'Vos vehicules',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          onTap: () {
                            Get.toNamed("/vehicule_list");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.alt_route),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: const Text(
                            'Vos trajets',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          onTap: () {
                            Get.toNamed("/rides_list_page");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.directions),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: const Text(
                            'Vos courses',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          onTap: () {
                            Get.toNamed("/race_list_page");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.payment),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: const Text(
                            'Paiements',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          onTap: () {
                            Get.toNamed("/payment_list_page");
                            // Navigator.pushNamed(context, '/vod');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.history),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: const Text(
                            "Rechargements",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          onTap: () {
                            // Navigator.pushNamed(context, '/about');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: const Text(
                            'Paramètres',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          onTap: () {
                            Get.toNamed("/settings_page");
                            // Navigator.pushNamed(context, '/about');
                          },
                        ),
                        // ListTile(
                        //   leading: Icon(Icons.headset),
                        //   trailing: Icon(Icons.arrow_forward_ios),
                        //   title: const Text(
                        //     "Support d'Assistance",
                        //     style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.normal),
                        //   ),
                        //   onTap: () async {
                        //     // await Get.toNamed("/login");
                        //     // var prefs = await SharedPreferences.getInstance();
                        //     // var removedToken = await prefs.remove("token");
                        //     // var removedPlayerId = await prefs.remove("playerId");
                        //   },
                        // ),
                      ],
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget getLine() {
    return SizedBox(
      height: 0.5,
      child: Container(
        color: Colors.grey,
      ),
    );
  }

  Widget getListTile(title, {Function? onTap}) {
    return ListTile(
      title: Text(title),
      onTap: () {},
    );
  }
}
