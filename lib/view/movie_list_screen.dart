import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/data/bean/now_playing_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/widget/row_movies_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieListScreen extends StatefulWidget {
  String apiName, dynamicList, titleTag;
  int movieId;

  MovieListScreen(
      {this.apiName, this.dynamicList, this.movieId, this.titleTag});

  @override
  _MovieListScreenState createState() =>
      _MovieListScreenState(apiName, dynamicList, movieId, titleTag);
}

class _MovieListScreenState extends State<MovieListScreen> {
  _MovieListScreenState(
      this.apiName, this.dynamicList, this.movieId, this.titleTag);

  int movieId;
  String castCrewTitle, titleTag;
  MovieModel model;
  String apiName, dynamicList;

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    model.trandingMovie();
  }

  @override
  Widget build(BuildContext context) {
    var homeIcon = IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorConst.BLACK_COLOR,
        ),
        onPressed: () => SystemNavigator.pop());
    return WillPopScope(
        onWillPop: () {
          return onWillPop(context);
        },
        child: Scaffold(
            appBar: getAppBarWithBackBtn(
                ctx: context,
                title: 'Tranding Movie',
                bgColor: Colors.white,
                titleTag: titleTag,
                icon: homeIcon),
            body: ScopedModel(model: model, child: apiresponse())));
  }

  Widget apiresponse() {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.getTrandingMovie;
        if (jsonResult.status == ApiStatus.COMPLETED) {
          return _createUi(jsonResult.data);
        } else
          return apiHandler(
              loading: RowMoviesScreen(
                isShowShimmer: true,
              ),
              response: jsonResult);
      },
    );
  }

  Widget _createUi(data) {
    return Container(
      alignment: Alignment.center,
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: data.results.length,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(6.0),
          child: getItemView(data, index),
        ),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  Widget getItemView(data, int index) {
    Result item = data.results[index];
    return RowMoviesScreen(
        context: context,
        apiName: apiName,
        index: index,
        height: 240,
        width: 135,
        id: item.id,
        img: item.poster_path,
        name: item.original_title,
        vote: item.vote_average,
        isShowShimmer: false,
        onTap: () {});
  }
}

Future<bool> onWillPop(BuildContext context) async {
  return showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: getTxtColor(
              msg: "Are you sure you want to exit this app?",
              fontSize: 17,
              txtColor: ColorConst.GREY_800),
          title: getTxtBlackColor(
              msg: "Warning!", fontSize: 18, fontWeight: FontWeight.bold),
          actions: <Widget>[
            FlatButton(
                child: getTxtBlackColor(
                  msg: "Yes",
                  fontSize: 17,
                ),
                onPressed: () => SystemNavigator.pop()),
            FlatButton(
                child: getTxtBlackColor(
                  msg: "No",
                  fontSize: 17,
                ),
                onPressed: () => Navigator.pop(context)),
          ],
        );
      });
}
