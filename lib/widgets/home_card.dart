import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:fade_shimmer/fade_shimmer.dart';

import '../models/movies.dart';
import '../screens/details.dart';
import '../provider/fav_provider.dart';
import 'numbers.dart';

class HomeCard extends StatelessWidget {

  final Movie movie;
  final int index;

  const HomeCard({
    Key? key,
    required this.movie,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<FavPro>(context, listen: false).updateId(movie.id);
            Navigator.push(context,MaterialPageRoute(builder: (context) => const Details()));
          },
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                height: 250,
                width: 180,
                errorBuilder: (ctx, __, ___) => const Icon(
                  Icons.broken_image,
                  size: 180,
                ),
                loadingBuilder: (ctx, __, ___) {
                  if (___ == null) return __;
                  return const FadeShimmer(
                    width: 180,
                    height: 250,
                    highlightColor: Color(0xff22272f),
                    baseColor: Color(0xff20252d),
                  );
                },
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: IndexNumber(number: index),
        )
      ],
    );
  }
}