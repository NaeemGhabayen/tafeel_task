import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tafeel_task/di_container.dart' as di ;
import 'package:tafeel_task/helper/network_info.dart';
import 'package:tafeel_task/helper/route_helper.dart';
import 'package:tafeel_task/provider/user_provider.dart';
import 'package:tafeel_task/theme/light_theme.dart';
import 'package:tafeel_task/utils/app_constants.dart';
import 'package:tafeel_task/view/screen/splash/splash_screen.dart';
import 'package:tafeel_task/view/widgets/network_aware_widget.dart';

final context = RouteHelper.routeHelper.navigationKey.currentState!.context;
final size = MediaQuery.of(context).size;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Intl.defaultLocale = 'er';

  await di.init();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      fallbackLocale: const Locale('er'),
      supportedLocales: const [Locale('er'), Locale('ar')],
      saveLocale: true,
      startLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => di.sl<UserProvider>()),

        ],
        child: const MyApp(),
      ),
    ),
  );}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  bool isConnected = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkInternetConnection();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
  }

  void _checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    bool newConnectionStatus = result != ConnectivityResult.none;
    if (isConnected != newConnectionStatus) {
      isConnected = newConnectionStatus;
      _showSnackbar(isConnected);
    }
  }

  void _showSnackbar(bool isConnected) {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          isConnected ? "تم معاودة الاتصال ✅" : "لا يوجد اتصال في الانترنت ❌",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: isConnected ? Colors.green : Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        ([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]));
    return MaterialApp(
        locale: Locale('ar'),
        scaffoldMessengerKey: _scaffoldMessengerKey,
        navigatorKey: RouteHelper.routeHelper.navigationKey,
        builder: (BuildContext context, Widget? child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(textScaler: TextScaler.linear(1.0)),
            child: NetworkAwareWidget(
              connectionStatus: NetworkService().connectionStatus,
              child: child!,
            ),
          );
        },
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: light,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: EasyLocalization.of(context)!.supportedLocales,
        home: SplashScreen());
  }
}
