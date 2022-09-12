import 'package:flutter/material.dart';

import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:provider/provider.dart';

import '../provider/fav_provider.dart';
import '../models/movies.dart';
import '../screens/details.dart';

class Items extends StatelessWidget {
  final Movie movie;

  const Items({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;

    return InkWell(
        onTap: () {
          Provider.of<FavPro>(context, listen: false).updateId(movie.id);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Details()));
          },
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 8,
            margin: const EdgeInsets.all(8),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: Hero(
                    tag: movie.title,
                    child: Image.network(
                      movie.posterPath,
                      height: 250,
                      width: width,
                      fit: BoxFit.fill,
                      loadingBuilder: (_, __, ___) {
                        if (___ == null) return __;
                        return FadeShimmer(
                          width: width,
                          height: 250,
                          highlightColor: const Color(0xff22272f),
                          baseColor: const Color(0xff20252d),
                        );
                      },
                      errorBuilder: (_, __, ___) => const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.broken_image,
                          size: 250,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${(movie.rate * 10).round() / 10}'),
                      const SizedBox(width: 6,),
                      const Icon(Icons.star,color: Colors.amber,)
                    ],
                  ),
                ),
              ],
            ),
        )
    );
  }
}
