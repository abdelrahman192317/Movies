import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../widgets/items.dart';
import '../provider/fav_provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    return Consumer<FavPro>(
      builder: (ctx, val, _) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  suffixIcon: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(3.14),
                      child: const Icon(Icons.search)
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.only(left: 16,),
                  filled: true,
                  fillColor: const Color(0xFF3A3F47),
                  hintText: 'Search',
                ),
                onChanged: (text) => val.setText(text),
              ),
              Expanded(
                child: val.search == ''
                    ? Center(child: SvgPicture.asset('assets/search.svg', height: 300))
                    : val.searchedMovies.isEmpty
                    ? Center(child: SvgPicture.asset('assets/signal.svg', height: 300))
                    : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .68
                      ),
                      itemBuilder: (ctx, index) => Items(
                        movie: val.searchedMovies[index],
                      ),
                      itemCount: val.searchedMovies.length,
                  ),
              ),
            ],
          ),
        );
      }
    );
  }
}
