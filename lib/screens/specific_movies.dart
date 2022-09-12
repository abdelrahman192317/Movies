import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';

import '../provider/fav_provider.dart';
import '../widgets/items.dart';

class SMovies extends StatefulWidget {

  static const String routeNamed = 'SMovies';

  const SMovies({Key? key}) : super(key: key);

  @override
  SMoviesState createState() => SMoviesState();
}

class SMoviesState extends State<SMovies> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
      Provider.of<FavPro>(context, listen: false).getCustomMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavPro>(
        builder: (ctx, val, _) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text('Enjoy',
                style: TextStyle(fontSize: 25,color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: val.customMovies.isEmpty
                ? Center(child: SvgPicture.asset('assets/signal.svg', height: 300))
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .68
                    ),
                    itemBuilder: (ctx, index) => Items(
                      movie: val.customMovies[index],
                    ),
                    itemCount: val.customMovies.length,
                ),
            drawer: const MyDrawer(),
          );
        }
    );
  }
}
