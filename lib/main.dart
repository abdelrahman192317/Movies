import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/home_screen.dart';
import 'provider/fav_provider.dart';
import 'screens/specific_movies.dart';
import 'screens/sign.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavPro(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Movies",
        theme: ThemeData.dark(),
        initialRoute: HomeScreen.routeNamed,
        routes: {
          HomeScreen.routeNamed: (context) => const HomeScreen(),
          Sign.routeNamed: (context) => const Sign(),
          SMovies.routeNamed: (context) => const SMovies(),
        },
      ),
    );
  }
}
