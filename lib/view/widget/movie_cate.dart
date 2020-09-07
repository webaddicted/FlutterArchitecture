import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/data/home/movie_cat_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/details/movie_list_screen.dart';
import 'package:flutterarch/view/widget/tranding_movie_row.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieCate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: apiresponse(context));
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.getMovieCat;
        if (jsonResult.status == ApiStatus.COMPLETED)
          return getCate(context, jsonResult.data.genres);
        else
          return apiHandler(response: jsonResult);
      },
    );
  }

  Widget getCate(BuildContext context, List<Genres> genres) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(context: context, apiName: ApiConstant.GENRES_LIST),
        SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: genres.length,
                itemBuilder: (BuildContext context, int index) {
                  return getCatRow(context, genres[index]);
                }),
          ),
        ),
      ],
    );
  }

  Widget getCatRow(BuildContext context, Genres item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                loadCircleImg(ApiConstant.DEMO_IMG, 0, 80),
                ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Container(
                    height: 80,
                    width: 80,
                    color: ColorConst.BLACK_FADE,
                  ),
                ),
                Positioned.fill(
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Colors.redAccent,
                            onTap: () {
                              navigationPush(
                                  context,
                                  MovieListScreen(
                                      apiName: StringConst.MOVIE_CATEGORY,
                                      dynamicList: item.name,
                                      movieId: item.id));
                            }))),
              ],
            ),
            getTxtBlackColor(msg: item.name, fontWeight: FontWeight.w700)
          ],
        ),
      ),
    );
  }
}
