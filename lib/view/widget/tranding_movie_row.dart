import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          return getTradingList(context, jsonResult.data.results);
        else
          return apiHandler(response: jsonResult);
      },
    );
  }

  Widget getTradingList(BuildContext context, List<Result> results) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(context, apiName),
        SizedBox(height: 10),
        SizedBox(
          height: 190.0,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: results.length,
            itemBuilder: (context, index) {
              Result item = results[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                child: GestureDetector(
                  onTap: () => navigationPush(
                      context, DetailsMovieScreen(apiName, index)),
                  child: Expanded(
                    child: Hero(
                      tag: getTitle(apiName) + index.toString(),
                      child: Container(
                        child: ClipRRect(
                          child: Image.network(
                            ApiConstant.IMAGE_POSTER + item.poster_path,
                            fit: BoxFit.cover,
                            width: 125,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
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


