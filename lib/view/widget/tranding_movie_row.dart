import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/data/home/now_playing_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/details/detail_movie.dart';
import 'package:flutterarch/view/details/movie_list_screen.dart';
import 'package:flutterarch/view/home/home_screen.dart';
import 'package:flutterarch/view/widget/rating_result.dart';
import 'package:scoped_model/scoped_model.dart';

class TrandingMovieRow extends StatelessWidget {
  final apiName;

  TrandingMovieRow(this.apiName);

  @override
  Widget build(BuildContext context) {
    return Container(child: apiresponse(context)); //getTradingList(context);
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = getData(apiName, model);
        if (jsonResult.status == ApiStatus.COMPLETED)
          return jsonResult.data.results.length > 0
              ? getMovieList(context, apiName, jsonResult.data.results)
              : Container();
        else
          return apiHandler(response: jsonResult);
      },
    );
  }

  Widget getMovieList(
      BuildContext context, String apiName, List<Result> results) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(context: context, apiName: apiName),
        SizedBox(height: 10),
        SizedBox(
          height: 240.0,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: results.length,
            itemBuilder: (context, index) {
              Result item = results[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child:
                    getMovieItemRow(context, apiName, item, index, 185, 125, 1),
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget getMovieItemRow(BuildContext context, String apiName, Result item,
    int index, double height, double width, int maxLine) {
  return Container(
    child: Expanded(
      child: Hero(
        tag: getTitle(apiName) + index.toString(),
        child: Container(
          width: width,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  SizedBox(
                    height: height,
                    child: ClipRRect(
                      child: getCacheImage(
                          ApiConstant.IMAGE_POSTER + item.poster_path),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Positioned.fill(
                      child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.redAccent,
                            onTap: () => navigationPush(
                                context,
                                DetailsMovieScreen(
                                    apiName, index, item.id.toString())),
                          ))),
                ],
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: getTxtBlackColor(
                      msg: item.title,
                      maxLines: maxLine,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
//                  getTxtBlackColor(
//                      msg: item.vote_average.toString(),
//                      fontSize: 12,
//                      fontWeight: FontWeight.bold),
                  RatingResult(item.vote_average, 12.0),
                  SizedBox(
                    width: 5.0,
                  ),
                  RatingBar(
                    itemSize: 12.0,
                    initialRating: item.vote_average / 2,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: _getBackgrountRate(item.vote_average),
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
Color _getBackgrountRate(double rate) {
  if (rate < 5.0) {
    return Colors.red;
  } else if (rate < 6.8) {
    return Colors.yellow;
  } else if (rate < 7.3) {
    return Colors.blue;
  } else {
    return Colors.green;
  }
}

Widget getHeading({BuildContext context, String apiName, bool isShowViewAll}) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, right: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        getTxtBlackColor(
            msg: getTitle(apiName), fontSize: 19, fontWeight: FontWeight.w700),
//        if (isShowViewAll)
        GestureDetector(
          onTap: () {
            navigationPush(context, MovieListScreen(apiName));
          },
          child: getTxtColor(
              msg: StringConst.VIEW_ALL,
              txtColor: Colors.blue,
              fontWeight: FontWeight.w800),
        )
      ],
    ),
  );
}
