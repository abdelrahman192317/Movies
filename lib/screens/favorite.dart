import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../provider/fav_provider.dart';
import '../widgets/items.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  FavoriteState createState() => FavoriteState();
}

class FavoriteState extends State<Favorite> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<FavPro>(context, listen: false).getFavMovies();
      }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavPro>(
      builder: (ctx, val, _) {
        return Scaffold(
          body: val.favIntMovies.isEmpty
              ? Center(child: SvgPicture.asset('assets/fav.svg', height: 300))
              : val.favMovies.isEmpty
              ? Center(child: SvgPicture.asset('assets/signal.svg', height: 300))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .68
                  ),
                  itemBuilder: (ctx, index) => Items(
                    movie: val.favMovies[index],
                  ),
                  itemCount: val.favMovies.length,
              ),
        );
      }
    );
  }
}
