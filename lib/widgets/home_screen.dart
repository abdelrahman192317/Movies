import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../provider/fav_provider.dart';
import '../screens/home.dart';
import '../screens/favorite.dart';
import '../screens/search.dart';
import '../widgets/drawer.dart';
import '../screens/sign.dart';

class HomeScreen extends StatefulWidget {

  static const String routeNamed = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  List<Widget> listOfBottomBar = [const Home(), const Favorite(), const Search()];
  List<String> listOfAppBarText = ['All What You Want', 'Favorite List', 'Search'];

  getSavedSign() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String reJson = pref.getString('sign') ?? '';
    if(reJson != 'true')Navigator.pushReplacementNamed(context, Sign.routeNamed);
  }

  @override
  void initState() {
    getSavedSign();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
      Provider.of<FavPro>(context, listen: false).getSavedFavData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavPro>(
      builder: (ctx, val, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(listOfAppBarText[val.selected]),
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            actions: [
              IconButton(
                onPressed: () {
                  val.logout();
                  Navigator.pushReplacementNamed(context, Sign.routeNamed);
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: listOfBottomBar[val.selected],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 8,
            onTap: (index) => val.setSelectedBar(index),
            type: BottomNavigationBarType.shifting,
            currentIndex: val.selected,
            selectedItemColor: Colors.blueAccent,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon( val.selected == 1?
                    Icons.favorite : Icons.favorite_border),
                label: "Favorite",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              )
            ],
          ),
          drawer: const MyDrawer(),
        );
      }
    );
  }
}
