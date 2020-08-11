import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/data/home/now_playing_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/details/detail_movie.dart';
import 'package:flutterarch/view/home/home_screen.dart';
import 'package:flutterarch/view/widget/tranding_movie_row.dart';
import 'package:scoped_model/scoped_model.dart';

class SifiMovieRow extends StatelessWidget {
  final apiName;

  SifiMovieRow(this.apiName);

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
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(context: context, apiName: apiName),
        SizedBox(height: 10),
        SizedBox(
          height: 190.0,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: results.length,
            itemBuilder: (context, index) {
              var item = results[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                child: Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: getTitle(apiName) + index.toString(),
                      child: Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 150,
                              width: size.width - 80,
                              child: ClipRRect(
                                child: Image.network(
                                  ApiConstant.IMAGE_POSTER + item.poster_path,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Positioned.fill(
                                child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      splashColor: Colors.redAccent,
                                      onTap: () => navigationPush(
                                          context,
                                          DetailsMovieScreen(apiName, index,
                                              item.id.toString())),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: getTxtBlackColor(
                            msg: item.original_title,
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                  ],
                )),
              );
            },
          ),
        ),
      ],
    );
  }
}
