import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zakazi/src/data/auth.dart';
import 'package:zakazi/src/data/bottomNavigation.dart';
import 'package:zakazi/src/data/salonsData.dart';
import 'package:zakazi/src/screens/login/loginScreen.dart';
import 'package:zakazi/src/screens/mainScreen.dart';
import './routes.dart';
import 'data/bottomNavigation.dart';
import 'data/categoriesData.dart';
import 'screens/home/home_screen.dart';

class Zakazi extends StatelessWidget {
  const Zakazi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthData>(
          create: (context) => AuthData(),
        ),
        ChangeNotifierProvider<CategoriesData>(
          create: (context) => CategoriesData(),
        ),
        ChangeNotifierProvider<SalonsData>(
          create: (context) => SalonsData(),
        ),
        ChangeNotifierProvider<BottomNavigation>(
          create: (context) => BottomNavigation(),
        ),
      ],
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Appointments',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            // primarySwatch: Colors.blue,
            fontFamily: "Poppins",
            textTheme: const TextTheme(
                bodyText1: TextStyle(color: Colors.black),
                bodyText2: TextStyle(color: Colors.black)),
          ),
          initialRoute: LoginScreen.routeName,
          routes: routes,
        ),
        designSize: const Size(375, 812),
      ),
    );
  }
}
