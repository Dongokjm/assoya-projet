import 'package:assoya/forms/vehicule.dart';
import 'package:assoya/pages/auth_login.dart';
import 'package:assoya/pages/auth_register.dart';
import 'package:assoya/pages/home_pageview.dart';
import 'package:assoya/pages/map_page.dart';
import 'package:assoya/pages/my_race_list.dart';
import 'package:assoya/pages/my_rides_list.dart';
import 'package:assoya/pages/payment_list_page.dart';
import 'package:assoya/pages/place_search_page.dart';
import 'package:assoya/pages/points_page.dart';
import 'package:assoya/pages/route_details_page.dart';
import 'package:assoya/pages/route_filter_page.dart';
import 'package:assoya/pages/route_list_page.dart';
import 'package:assoya/pages/settings_page.dart';
import 'package:assoya/pages/splashscreen_page.dart';
import 'package:assoya/pages/user_profile_page.dart';
import 'package:assoya/pages/vehicule_details.dart';
import 'package:assoya/pages/vehicule_list_page.dart';
import 'package:assoya/pages/verification_code_page.dart';
import 'package:assoya/providers/auth_provider.dart';
import 'package:assoya/providers/data_provider.dart';
import 'package:assoya/providers/place_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => PlaceProvider()),
          ChangeNotifierProvider(create: (_) => DataProvider()),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          enableLog: true,
          title: 'Assoya',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
              })),
          defaultTransition: Transition.zoom,
          localizationsDelegates: [
            FormBuilderLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''), // English, no country code
            Locale('fr', ''), // Spanish, no country code
          ],
          initialRoute: '/splash',
          routes: {
            '/home': (context) => const HomePageView(),
            '/verification': (context) => const VerificationCodePage(),
            '/splash': (context) => const SplashScreenPage(),
            '/login': (context) => const AuthLoginPage(),
            '/register': (context) => const AuthRegisterPage(),
            '/maps': (context) => MapPage(),
            '/route_list': (context) => RouteListPage(),
            '/race_list_page': (context) => MyRaceListPage(),
            '/vehicule_list': (context) => VehiculeListPage(),
            '/vehicule_details': (context) => VehiculeDetailsPage(),
            '/vehicule_form': (context) => VehiculeForm(),
            '/user_profile_page': (context) => UserProfilePage(),
            '/place_search': (context) => CustomSearchScaffold(),
            '/points': (context) => PointsPage(),
            '/settings_page': (context) => SettingsPage(),
            '/route_details': (context) => RouteDetailsPage(),
            '/route_filter_page': (context) => RouteFilterPage(),
            '/rides_list_page': (context) => MyRideListPage(),
            '/payment_list_page': (context) => PaymentListPage(),
          },
        ));
  }
}
