import 'package:fastfilldashboard/ui/home/home_page.dart';
import 'package:fastfilldashboard/ui/language/language_page.dart';
import 'package:fastfilldashboard/utils/local_data.dart';
import 'package:fastfilldashboard/utils/misc.dart';
import 'package:fastfilldashboard/utils/notifications.dart';
import 'package:fastfilldashboard/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logger/logger.dart';

import 'firebase_options.dart';
import 'helper/app_colors.dart';
import 'helper/methods.dart';
import 'package:shared_preferences/shared_preferences.dart';


final logger = Logger();
bool isSigned=false;
String languageCode = "en";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
  );

  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en', supportedLocales: ['en', 'ar']);

  getCurrentUserValue().then((v) {
      if (v.id != null)
        if (v.id != 0)
          isSigned = true;
  });

  notifications.init(notificationsController);


  getLanguage().then((l) {
      if (l.isNotEmpty)
      {
        languageCode = l;
      }
  });

  runApp(ProviderScope(child:LocalizedApp(delegate, FastFillAdminPanelApp())));
}

class FastFillAdminPanelApp extends StatefulWidget {
  @override
  _FastFillAdminPanelApp createState() => _FastFillAdminPanelApp();

  static void setLocale(BuildContext context, Locale newLocale) async {
    _FastFillAdminPanelApp? state = context.findAncestorStateOfType<_FastFillAdminPanelApp>();
    state?.changeLanguage(newLocale);
  }

  static Locale? getLocale(BuildContext context) {
    _FastFillAdminPanelApp? state = context.findAncestorStateOfType<_FastFillAdminPanelApp>();
    return state?.getLanguage();
  }

//static _FastFillApp? of(BuildContext context) => context.findAncestorStateOfType<_FastFillApp>();
}

class _FastFillAdminPanelApp extends State<FastFillAdminPanelApp> {
  Locale _locale = Locale.fromSubtags(languageCode: languageCode);

  changeLanguage(Locale value) {
    if (mounted) {
      setState(() {
        _locale = value;
      });
    }
  }

  Locale getLanguage()
  {
    return _locale;
  }

  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light)); */
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: DismissKeyboard(child: Directionality(
            textDirection: (isArabic()) ? TextDirection.rtl : TextDirection.ltr,
            child: GetMaterialApp(
          title: 'Fast Fill Admin Panel',
              onGenerateInitialRoutes:
                  (String initialRouteName) {
                return [
                  AppRouter.generateRoute(RouteSettings(name:
                  (isSigned) ? HomePage.route : LanguagePage.route,
                      arguments: null
                  ))
                ];
              },
              onGenerateRoute: AppRouter.generateRoute,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            localizationDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: _locale,
          theme: ThemeData(
              appBarTheme: AppBarTheme(color: backgroundColor1,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: backgroundColor1,
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.light,
                  )
              ),
              primaryColor: primaryColor1,
              accentColor: primaryColor2,
              fontFamily: isArabic() ? 'Poppins' : 'Poppins'),
          initialRoute: (isSigned) ? HomePage.route : LanguagePage.route,
        ))));
  }
}
