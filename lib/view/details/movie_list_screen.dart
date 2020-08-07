import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/data/home/now_playing_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/home/home_screen.dart';
import 'package:flutterarch/view/widget/tranding_movie_row.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieListScreen extends StatefulWidget {
  String apiName;

  MovieListScreen(this.apiName);

  @override
  _MovieListScreenState createState() => _MovieListScreenState(apiName);
}

class _MovieListScreenState extends State<MovieListScreen> {
  _MovieListScreenState(this.apiName);

  MovieModel model;
  String apiName;

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    callMovieApi(apiName, model);
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
        if (jsonResult.status == ApiStatus.COMPLETED)
          return _createUi(jsonResult.data.results);
        else
          return apiHandler(response: jsonResult);
      },
    );
  }

  Widget _createUi(List<Result> results) {
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
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(6.0),
          child: getMovieItemRow(
              context, apiName, results[index], index, 240, 135, 1),
        ),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    ));
  }
}
