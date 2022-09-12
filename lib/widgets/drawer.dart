import 'package:flutter/material.dart';
import 'package:marvel/widgets/home_screen.dart';
import 'package:provider/provider.dart';

import '../provider/fav_provider.dart';
import '../screens/specific_movies.dart';
import '../apis/urls.dart';

class MyDrawer extends StatelessWidget {

  const MyDrawer({super.key});

  Widget buildTile(String title, IconData icon, Function() x) {
    return ListTile(
      onTap: x,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      leading: Icon(icon),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;

    return Consumer<FavPro>(
      builder: (ctx, val, _) => Drawer(
        child: Column(
          children: [
            Container(
              height: 120,
              width: width,
              padding: const EdgeInsets.all(20),
              color: Theme.of(context).colorScheme.secondary,
              alignment: Alignment.centerLeft,
              child: Text(
                'Movies',
                style: TextStyle(fontSize: 30, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w900,),
              ),
            ),
            const SizedBox(height: 20,),
            buildTile('Home', Icons.home,
                    () {Navigator.of(context).pushReplacementNamed(HomeScreen.routeNamed);}),
            buildTile('Top Rated Movies', Icons.star_rate,
                    () {val.setKind(Urls.topRated);
                  Navigator.of(context).pushReplacementNamed(SMovies.routeNamed);
                }),
            buildTile('Popular Movies', Icons.group,
                    () {val.setKind(Urls.popularMovies);
                  Navigator.of(context).pushReplacementNamed(SMovies.routeNamed);
                }),
            buildTile('New Playing Movies', Icons.play_circle,
                    () {val.setKind(Urls.newPlayingMovies);
                  Navigator.of(context).pushReplacementNamed(SMovies.routeNamed);
                }),
            buildTile('Upcoming Movies', Icons.upcoming,
                    () {val.setKind(Urls.upcomingMovies);
                  Navigator.of(context).pushReplacementNamed(SMovies.routeNamed);
                }),
          ],
        ),
      )
    );
  }
}
