import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/data/home/now_playing_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/details/detail_movie.dart';
import 'package:flutterarch/view/home/home_screen.dart';
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
      child: GridView.builder(
          itemCount: results.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.1 / 1.4),
          itemBuilder: (BuildContext context, int index) {
            Result item = results[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: InkWell(
                  onTap: () {
                    navigationPush(
                        context, DetailsMovieScreen(apiName, index));
                  },
                  child: SizedBox(
                    height: 250,
                    child: Container(
                        height: 250,
                        child: Hero(
                            tag: apiName + index.toString(),
                            child: Image.network(
                              ApiConstant.IMAGE_POSTER + item.poster_path,
                              fit: BoxFit.cover,
                              height: 180,
                            ))),
                  ),
                ),
              ),
            );
          }),
    ));
  }
}
