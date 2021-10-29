import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migscourier/constants.dart';
import 'package:migscourier/managers/user.dart';
import 'package:migscourier/models/user.dart';
import 'package:migscourier/screens/wrapper.dart';
import 'package:migscourier/services/network/auth.dart';
import 'package:migscourier/managers/firestore.dart';
import 'package:migscourier/services/network/orders.dart';
import 'package:migscourier/services/network/revenue.dart';
import 'package:migscourier/services/network/user.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  runApp(
    MultiProvider(
      providers: [
        StreamProvider<User>.value(value: UserManager().user, initialData: null),
        ProxyProvider<User, FirestoreManager>(update: (_, user, __) => FirestoreManager(uid: user?.id)),
        ChangeNotifierProvider<AuthServices>(create: (context) => AuthServices(packageInfo: packageInfo), lazy: false),
        ChangeNotifierProvider<UserDataServices>(create: (context) => UserDataServices(), lazy: false),
        ChangeNotifierProvider<OrdersServices>(create: (context) => OrdersServices(), lazy: false),
        ChangeNotifierProvider<RevenueServices>(create: (context) => RevenueServices(), lazy: false),
      ],
      child: MigsCourier(),
    )
  );
}

class MigsCourier extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Courier Mobile',
      theme: ThemeData(
        primaryColor: kMainThemeColor,
        scaffoldBackgroundColor: kScaffoldBGColor,
        fontFamily: 'Biryani',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 96.0, fontWeight: FontWeight.w300),
          headline2: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w300),
          headline3: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w400),
          headline4: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w400),
          headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
          headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          subtitle1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
          subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
          bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
          button: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
          overline: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400),
        ),
      ),
      home: Wrapper(),
    );
  }

}