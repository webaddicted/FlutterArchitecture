import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/data/details/credits_crew_respo.dart';
import 'package:flutterarch/data/home/now_playing_respo.dart';
import 'package:flutterarch/data/person/tranding_person_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/home/home_screen.dart';
import 'package:flutterarch/view/person/person_detail.dart';
import 'package:flutterarch/view/widget/movie_cast_crew.dart';
import 'package:flutterarch/view/widget/tranding_movie_row.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieListScreen extends StatefulWidget {
  String apiName;
  int movieId;

  MovieListScreen({this.apiName, this.movieId});

  @override
  _MovieListScreenState createState() =>
      _MovieListScreenState(apiName, movieId);
}

class _MovieListScreenState extends State<MovieListScreen> {
  _MovieListScreenState(this.apiName, this.movieId);

  int movieId;
  String castCrewTitle;
  MovieModel model;
  String apiName;

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    callMovieApi(apiName, model, movieId: movieId);
  }

  @override
  Widget build(BuildContext context) {
    var homeIcon = IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorConst.BLACK_COLOR,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
    return Scaffold(
        appBar: getAppBarWithBackBtn(
            ctx: context,
            title: getTitle(apiName),
            bgColor: Colors.white,
            icon: homeIcon),
        body: ScopedModel(model: model, child: apiresponse()));
  }

  Widget apiresponse() {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = getData(apiName, model);
        if (jsonResult.status == ApiStatus.COMPLETED) {
          return _createUi(jsonResult.data);
        } else
          return apiHandler(response: jsonResult);
      },
    );
  }

  Widget _createUi(data) {
    final size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Container(
//      width: double.infinity,
//      height: double.infinity,
        child: Container(
      alignment: Alignment.center,
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: getInstance(data),
        //results.length,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(6.0),
          child: getItemView(data, index),
        ),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    ));
  }

  int getInstance(result) {
    if (apiName == StringConst.MOVIE_CAST && result is CreditsCrewRespo)
      return result.cast.length;
    else if (apiName == StringConst.MOVIE_CREW && result is CreditsCrewRespo)
      return result.crew.length;
    else if (result is TrandingPersonRespo)
      return result.results.length;
    else if (result is NowPlayingRespo)
      return result.results.length;
    else
      return 1;
  }

  Widget getItemView(data, int index) {
    if (data is CreditsCrewRespo) return getPersonDetails(data, index);
    if (data is TrandingPersonRespo) {
      var result = data.results[index];
      var tag = apiName + 'tranding' + index.toString();
      return castCrewItem(
          id: result.id,
          name: result.name,
          tag: tag,
          image: result.profilePath,
          job: result.knownForDepartment,
          onTap: (int id) => navigationPush(context,
              PersonDetail(id: id, imgPath: result.profilePath, tag: tag)));
    } else if (data is NowPlayingRespo)
      return getMovieItemRow(
          context, apiName, data.results[index], index, 240, 135, 1);
    else
      Container(
        child: getTxt(msg: 'Data not found'),
      );
  }

  Widget getPersonDetails(CreditsCrewRespo results, int index) {
    String image = apiName == StringConst.MOVIE_CAST
        ? results.cast[index].profilePath
        : results.crew[index].profilePath;
    String name = apiName == StringConst.MOVIE_CAST
        ? results.cast[index].name
        : results.crew[index].name;
    String chatactor = apiName == StringConst.MOVIE_CAST
        ? results.cast[index].character
        : results.crew[index].job;
    int id = apiName == StringConst.MOVIE_CAST
        ? results.cast[index].id
        : results.crew[index].id;
    var tag = apiName + 'cast_crew list' + index.toString();
    return castCrewItem(
        id: id,
        name: name,
        tag: tag,
        image: image,
        job: chatactor,
        onTap: (int id) => navigationPush(
            context, PersonDetail(id: id, imgPath: image, tag: tag)));
  }
}
