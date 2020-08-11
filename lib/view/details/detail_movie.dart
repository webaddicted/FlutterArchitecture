import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/data/details/movie_details_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/home/home_screen.dart';
import 'package:flutterarch/view/widget/genre_movie.dart';
import 'package:flutterarch/view/widget/movie_cast_crew.dart';
import 'package:flutterarch/view/widget/movie_keyword.dart';
import 'package:flutterarch/view/widget/rating_result.dart';
import 'package:flutterarch/view/widget/tranding_movie_row.dart';
import 'package:flutterarch/view/widget/video_view.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailsMovieScreen extends StatefulWidget {
  final apiName;
  final index;
  final movieId;

  DetailsMovieScreen(this.apiName, this.index, this.movieId);

  @override
  _DetailsMovieScreenState createState() =>
      _DetailsMovieScreenState(apiName, index, movieId);
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen> {
  final apiName;
  final index;
  final movieId;
  MovieModel model;
  final double expandedHeight = 350.0;

  _DetailsMovieScreenState(this.apiName, this.index, this.movieId);

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    model.movieDetails(movieId);
    model.movieCrewCast(movieId);
    model.fetchRecommendMovie(movieId);
    model.fetchSimilarMovie(movieId);
    model.movieKeyword(movieId);
    model.movieVideo(movieId);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScopedModel(model: model, child: apiresponse(context)));
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.getMovieDetails;
        if (jsonResult.status == ApiStatus.COMPLETED)
          return _createUi(jsonResult.data);
        else
          return apiHandler(response: jsonResult);
      },
    );
  }

  Widget _createUi(MovieDetailsRespo data) {
//    print(' obj   :  ' + data.releaseDate);
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _helperImage(data),
        ),
        CustomScrollView(
          slivers: <Widget>[
            _appBarView(),
            _contentSection(data),
          ],
        ),
      ],
    );
  }

  Widget _helperImage(MovieDetailsRespo data) {
    return Container(
      height: expandedHeight + 50,
      width: double.infinity,
      child: Hero(
          tag: getTitle(apiName) + index.toString(),
          child: Container(
            child:
                getCacheImage(ApiConstant.IMAGE_ORIG_POSTER + data.posterPath),
          )),
    );
  }

  Widget _appBarView() {
    return SliverAppBar(
      leading: Container(
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            model.movieDetails(movieId);
            model.movieCrewCast(movieId);
//            model.fetchRecommendMovie(movieId);
//            model.fetchSimilarMovie(movieId);
            model.movieKeyword(movieId);
//            Navigator.pop(context);
          },
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      expandedHeight: expandedHeight - 50,
      snap: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(color: Colors.transparent),
        ),
      ),
    );
  }

  Widget _contentSection(MovieDetailsRespo data) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [getContai(data)],
      ),
    );
  }

  Widget getContai(MovieDetailsRespo data) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _contentTitle(data),
          MovieCastCrew(StringConst.MOVIE_CAST),
          MovieCastCrew(StringConst.MOVIE_CREW),
//          getHeading(context: context, apiName: 'Keyword'),
          VideoView('Trailer'),
          MovieKeyword('Keyword'),
          TrandingMovieRow(ApiConstant.RECOMMENDATIONS_MOVIE),
          TrandingMovieRow(ApiConstant.SIMILAR_MOVIES),
        ],
      ),
    );
  }

  Widget _contentTitle(MovieDetailsRespo movie) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: getTxtBlackColor(
                    msg: movie.originalTitle,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              RatingResult(movie.voteAverage, 12.0)
            ],
          ),
          SizedBox(height: 7),
          GenreMovie(items: movie.genres),
          SizedBox(height: 10),
          _contentAbout(movie),
          SizedBox(height: 10),
          getTxtBlackColor(
              msg: 'Overview', fontSize: 18, fontWeight: FontWeight.bold),
          SizedBox(height: 7),
          getTxtGreyColor(
              msg: movie.overview, fontSize: 15, fontWeight: FontWeight.w400),
        ],
      ),
    );
  }

  Widget _contentAbout(MovieDetailsRespo _dataMovie) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (_dataMovie.status != null)
                _contentDescriptionAbout('Status', _dataMovie.status),
              if (_dataMovie.runtime != null)
                _contentDescriptionAbout(
                    'Duration', '${_dataMovie.runtime} min'),
              _contentDescriptionAbout('Release Date', _dataMovie.releaseDate),
              if (_dataMovie.budget != null)
                _contentDescriptionAbout('Budget', '\$${_dataMovie.budget}'),
              if (_dataMovie.revenue != null)
                _contentDescriptionAbout('Revenue', '\$${_dataMovie.revenue}'),
            ],
          ),
          Container(
              width: 80,
              height: 125,
              child: getCacheImage(ApiConstant.IMAGE_POSTER +
                  _dataMovie
                      .backdropPath) //,ImageNetwork(getTheMovieImage(_dataMovie.backdropPath)),
              ),
        ],
      ),
    );
  }

  Widget _contentDescriptionAbout(String title, String value) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            getTxtBlackColor(
                msg: title,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start),
            Text(' : '),
            getTxtAppColor(
                msg: value,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget showKeyword() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(20.0),
        children: _getKeywordListings(), // <<<<< Note this change for the return type
      ),
    );
  }

  List<Widget> _getKeywordListings() {
    List listings = List<Widget>();
    int i = 0;
    for (i = 0; i < 5; i++) {
      listings.add(
        RadioListTile<String>(
          title: const Text('Lafayette'),
          value: "c",
          groupValue: "x",
          onChanged: (_) {

          },
        ),
      );
    }
    return listings;
  }
}
