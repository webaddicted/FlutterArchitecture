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
          return getMovieList(context, apiName, jsonResult.data.results);
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
        getHeading(context, apiName),
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
                    getMovieItemRow(context, apiName, item, index, 185, 125, 2),
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
    child: GestureDetector(
      onTap: () => navigationPush(context, DetailsMovieScreen(apiName, index, item.id.toString())),
      child: Expanded(
        child: Hero(
          tag: getTitle(apiName) + index.toString(),
          child: Container(
            width: width,
            child: Column(
              children: <Widget>[
                 SizedBox(
                    height: height,
                    child: ClipRRect(
                      child: getCacheImage(
                          ApiConstant.IMAGE_POSTER + item.poster_path),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(item.title,
                      maxLines: maxLine,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0)),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    getTxtBlackColor(
                        msg: item.vote_average.toString(),
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
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
                        color: Colors.blue,
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
    ),
  );
}

Widget getHeading(BuildContext context, String apiName) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, right: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        getTxtBlackColor(
            msg: getTitle(apiName), fontSize: 19, fontWeight: FontWeight.w700),
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
