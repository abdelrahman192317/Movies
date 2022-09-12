import 'package:flutter/material.dart';

import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:provider/provider.dart';

import '../provider/fav_provider.dart';

class Details extends StatefulWidget {

  const Details({
    Key? key,
  }) : super(key: key);

  @override
  DetailsState createState() => DetailsState();
}

class DetailsState extends State<Details> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<FavPro>(context, listen: false).getMovieDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    TextStyle a = const TextStyle(fontWeight: FontWeight.bold, color: Colors.amber);
    TextStyle b = const TextStyle(fontWeight: FontWeight.w500,color: Colors.white);

    return Consumer<FavPro>(
      builder: (ctx, val, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(val.movieDetails.title,
              style: const TextStyle(fontSize: 25,color: Colors.white),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: Column(
            children: [
              const SizedBox(height: 30),
              SizedBox(
                height: 330,
                child: Stack(
                  children: [
                    Hero(
                        tag: val.movieDetails.title,
                        child: Image.network(
                          val.movieDetails.backdropPath,
                          width: width,
                          height: 250,
                          fit: BoxFit.cover,
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
                        )
                    ),
                    Positioned(
                        bottom: 0,
                        left: 30,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            val.movieDetails.posterPath,
                            width: 100,
                            height: 140,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, __, ___) {
                              if (___ == null) return __;
                              return const FadeShimmer(
                                width: 100,
                                height: 140,
                                highlightColor: Color(0xff22272f),
                                baseColor: Color(0xff20252d),
                              );
                            },
                            errorBuilder: (_, __, ___) => const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.broken_image,
                                size: 120,
                              ),
                            ),
                          ),
                        )
                    ),
                    Positioned(
                      top: 225,
                      right: 20,
                      child: FloatingActionButton(
                        backgroundColor: Colors.blue,
                        onPressed: () =>
                        val.isFav(val.movieId)
                            ? val.deleteFromFav(val.movieId)
                            : val.addToFav(val.movieId),
                        child: val.isFav(val.movieId)
                            ? const Icon(Icons.favorite, color: Colors.black,)
                            : const Icon(Icons.favorite_border, color: Colors.black,),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Container(
                margin: const EdgeInsets.all(10),
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  elevation: 8,
                  shadowColor: Colors.lightBlueAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today),
                                    const SizedBox(width: 5),
                                    Text(val.movieDetails.releaseDate.split('-')[0]),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.play_circle),
                                    const SizedBox(width: 5),
                                    Text('${val.movieDetails.popularity}'),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    Text(val.movieDetails.rate == 0.0
                                        ? 'N/A'
                                        : '${(val.movieDetails.rate * 10).round() / 10}'
                                    ),
                                    const Icon(Icons.star,color: Colors.amber,),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text('${val.movieDetails.voteCount}'),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.person_outline),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text('Overview:', style: a,textAlign: TextAlign.center,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(val.movieDetails.overview, style: b,),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}