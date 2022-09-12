import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../widgets/home_card.dart';
import '../widgets/items.dart';
import '../provider/fav_provider.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavPro>(context, listen: false).getTopRatedMovies();
      Provider.of<FavPro>(context, listen: false).getPopularMovies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Consumer<FavPro>(
      builder: (ctx, val, child) => Scaffold(
          body: SingleChildScrollView(
            child: val.topRatedMovies.isEmpty ?
            SizedBox(
              height: height,
                child: const Center(child: SpinKitFoldingCube(color: Colors.lightBlue,),)) :
            Column(
              children: [
                const SizedBox(height: 5),
                SizedBox(
                  height: 300,
                  child: ListView.separated(
                    itemCount: val.topRatedMovies.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, __) => const SizedBox(width: 24),
                    itemBuilder: (_, index) =>
                        HomeCard(
                            movie: val.topRatedMovies[index],
                            index: index + 1
                        ),
                  ),
                ),
                const Text('Popular Movies',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue,),),
                const SizedBox(height: 10),
                Container(
                  width: width-20,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .68
                    ),
                    //shrinkWrap: true,
                    itemBuilder: (ctx, index) => Items(
                      movie: val.popularMovies[index],
                    ),
                    itemCount: val.popularMovies.length,
                  ),
                ),
              ],
            ),
          ),
      )
    );
  }
}
