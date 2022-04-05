import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:major_assignment/model/movie.dart';
import 'package:major_assignment/provider/movies_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var movies = Provider.of<MovieProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () =>
                        movies.getMoviesBySearch(_searchController.text),
                    icon: const Icon(
                      Icons.search,
                      size: 20,
                      color: Color(0xff4B4B4B),
                    ),
                  ),
                  hintText: "Search for movies",
                  hintStyle:
                      const TextStyle(color: Color(0xff4B4B4B), fontSize: 16.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0))),
            ),
          ),
          Expanded(
            child: movies.movies.length ==0?Center(child: AutoSizeText("Search something in search box!!",maxLines: 2,minFontSize: 24.0,),)  :ListView.builder(
                itemCount: movies.movies.length,
                itemBuilder: (_, index) {
                  return MovieItem(movies.movies[index]);
                }),
          )
        ],
      ),
    );
  }
}

class MovieItem extends StatefulWidget {
  Movie movie;
  MovieItem(this.movie);

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 5.0, color: Colors.black12, offset: Offset(2, 2)),
          ],
          borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              widget.movie.posterUrl,
              height: 180.0,
              width: 140.0,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ____) {
                return Image.network(
                  'https://www.fostercity.org/sites/default/files/styles/gallery500/public/imageattachments/parksrec/page/10791/thursday_movie.png?itok=XakMswGX',
                  height: 180.0,
                  width: 140.0,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(
            width: 24.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  widget.movie.title,
                  maxLines: 2,
                  minFontSize: 20.0,
                  style: TextStyle(
                      color: Color(0xff5B5F60), fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                AutoSizeText(
                  widget.movie.genre,
                  maxLines: 2,
                  style: TextStyle(color: Colors.black26),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color:double.parse(widget.movie.rating)>5.0? const Color(0xff60C773):const Color(0xff4C83E5)),
                    child: Text(
                      '${widget.movie.rating} IMDB',
                      style: const TextStyle(color: Colors.white),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
