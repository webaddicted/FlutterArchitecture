import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/widget/carousel_view.dart';
import 'package:flutterarch/view/widget/movie_cate.dart';
import 'package:flutterarch/view/widget/navig_drawer.dart';
import 'package:flutterarch/view/widget/sifi_movie_row.dart';
import 'package:flutterarch/view/widget/tranding_movie_row.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieModel model;

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    model.fetchNowPlaying();
    callMovieApi(ApiConstant.POPULAR_MOVIES, model);
    callMovieApi(ApiConstant.GENRES_LIST, model);
    callMovieApi(ApiConstant.TRENDING_MOVIE_LIST, model);
    callMovieApi(ApiConstant.DISCOVER_MOVIE, model);
    callMovieApi(ApiConstant.UPCOMING_MOVIE, model);
    callMovieApi(ApiConstant.TOP_RATED, model);
  }

  @override
  Widget build(BuildContext context) {
    var homeIcon = IconButton(
        icon: Icon(
          Icons.storage,
          color: ColorConst.BLACK_COLOR,
        ),
        onPressed: () {
//          model.fetchNowPlaying();
//          model.upcommingMovie();
//          Navigator.pop(context);
        });
    return Scaffold(
        appBar: getAppBarWithBackBtn(
            ctx: context,
            title: StringConst.HOME_TITLE,
            bgColor: Colors.white,
            icon: homeIcon),
        drawer: Drawer(
          child: NavDrawerView(),
        ),
        body: ScopedModel(model: model, child: _createUi()));
  }

  Widget _createUi() {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              CarouselView(),
              TrandingMovieRow(ApiConstant.POPULAR_MOVIES),
              MovieCate(),
              TrandingMovieRow(ApiConstant.TRENDING_MOVIE_LIST),
              SifiMovieRow(ApiConstant.UPCOMING_MOVIE),
              TrandingMovieRow(ApiConstant.DISCOVER_MOVIE),
              TrandingMovieRow(ApiConstant.TOP_RATED),
            ],
          ),
        ),
      ),
    );
  }
}

String getTitle(String apiName) {
  switch (apiName) {
    case ApiConstant.POPULAR_MOVIES:
      return 'Popular Movie';
    case ApiConstant.GENRES_LIST:
      return 'Category';
    case ApiConstant.TRENDING_MOVIE_LIST:
      return 'Tranding Movie';
    case ApiConstant.DISCOVER_MOVIE:
      return 'Discover Movie';
    case ApiConstant.UPCOMING_MOVIE:
      return 'Upcomming Movie';
    case ApiConstant.TOP_RATED:
      return 'Top Rated Movie';
  }
}

callMovieApi(String apiName, MovieModel model) {
  switch (apiName) {
    case ApiConstant.POPULAR_MOVIES:
      return model.fetchPopularMovie();
    case ApiConstant.GENRES_LIST:
      return model.fetchMovieCat();
    case ApiConstant.TRENDING_MOVIE_LIST:
      return model.trandingMovie();
    case ApiConstant.DISCOVER_MOVIE:
      return model.discoverMovie();
    case ApiConstant.UPCOMING_MOVIE:
      return model.upcommingMovie();
    case ApiConstant.TOP_RATED:
      return model.topRatedMovie();
  }
}

getData(String apiName, MovieModel model) {
  switch (apiName) {
    case ApiConstant.POPULAR_MOVIES:
      return model.popularMovieRespo;
    case ApiConstant.GENRES_LIST:
      return model.getMovieCat;
    case ApiConstant.TRENDING_MOVIE_LIST:
      return model.getTrandingMovie;
    case ApiConstant.DISCOVER_MOVIE:
      return model.getDiscoverMovie;
    case ApiConstant.UPCOMING_MOVIE:
      return model.getUpcommingMovie;
    case ApiConstant.TOP_RATED:
      return model.getTopRatedMovie;
  }
}
