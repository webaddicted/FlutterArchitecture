import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/data/details/movie_details_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/widget/genre_movie.dart';
import 'package:flutterarch/view/widget/movie_cast_crew.dart';
import 'package:flutterarch/view/widget/movie_keyword.dart';
import 'package:flutterarch/view/widget/rating_result.dart';
import 'package:flutterarch/view/widget/sifi_movie_row.dart';
import 'package:flutterarch/view/widget/tranding_movie_row.dart';
import 'package:flutterarch/view/widget/video_view.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailsMovieScreen extends StatefulWidget {
  final apiName;
  final tag;
  final index;
  final movieId;

  DetailsMovieScreen(this.apiName, this.index, this.movieId, this.tag);

  @override
  _DetailsMovieScreenState createState() =>
      _DetailsMovieScreenState(apiName, index, movieId, tag);
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen> {
  final apiName;
  final tag;
  final index;
  final movieId;
  MovieModel model;
  final double expandedHeight = 350.0;

  _DetailsMovieScreenState(this.apiName, this.index, this.movieId, this.tag);

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
    model.movieImg(movieId);
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
          tag: tag,
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
//            model.movieDetails(movieId);
//            model.movieCrewCast(movieId);
//            model.fetchRecommendMovie(movieId);
//            model.fetchSimilarMovie(movieId);
//            model.movieKeyword(movieId);
            Navigator.pop(context);
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
          SifiMovieRow(ApiConstant.MOVIE_IMAGES),
          MovieCastCrew(castCrew: StringConst.MOVIE_CAST, movieId: movieId),
          MovieCastCrew(castCrew: StringConst.MOVIE_CREW, movieId: movieId),
          getHeading(context: context, apiName: 'Keyword'),
          VideoView('Trailer'),
          MovieKeyword('Keyword'),
          TrandingMovieRow(apiName:ApiConstant.RECOMMENDATIONS_MOVIE, movieId:movieId),
          TrandingMovieRow(apiName:ApiConstant.SIMILAR_MOVIES, movieId:movieId),
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
                    msg: movie.originalTitle!=null?movie.originalTitle:'',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              RatingResult(movie.voteAverage, 12.0)
            ],
          ),
          SizedBox(height: 7),
          if(movie.genres!=null && movie.genres.length>0)
          GenreMovie(items: movie.genres),
          SizedBox(height: 10),
          _contentAbout(movie),
          SizedBox(height: 10),
          getTxtBlackColor(
              msg: 'Overview', fontSize: 18, fontWeight: FontWeight.bold),
          SizedBox(height: 7),
          getTxtGreyColor(
              msg: movie.overview!=null?movie.overview:'', fontSize: 15, fontWeight: FontWeight.w400),
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
                _contentDescriptionAbout('Status', _dataMovie.status!=null?_dataMovie.status:''),
              if (_dataMovie.runtime != null)
                _contentDescriptionAbout(
                    'Duration', '${_dataMovie.runtime} min'),
              if (_dataMovie.releaseDate != null)
              _contentDescriptionAbout('Release Date', _dataMovie.releaseDate!=null?_dataMovie.releaseDate:''),
              if (_dataMovie.budget != null)
                _contentDescriptionAbout('Budget', '\$${_dataMovie.budget!=null?_dataMovie.budget:''}'),
              if (_dataMovie.revenue != null)
                _contentDescriptionAbout('Revenue', '\$${_dataMovie.revenue!=null?_dataMovie.revenue:''}'),
            ],
          ),
          if(_dataMovie.backdropPath!=null)
          Container(
              width: 80,
              height: 125,
              child: getCacheImage(ApiConstant.IMAGE_POSTER +
                  _dataMovie.backdropPath!=null?_dataMovie.backdropPath:'')
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
                msg: title!=null?title:'',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start),
            Text(' : '),
            getTxtAppColor(
                msg: value!=null?value:'',
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
}
