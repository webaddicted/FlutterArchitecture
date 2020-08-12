import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/data/details/movie_img_respo.dart';
import 'package:flutterarch/data/home/now_playing_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/details/detail_movie.dart';
import 'package:flutterarch/view/home/home_screen.dart';
import 'package:flutterarch/view/widget/full_image.dart';
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
          return getCount(jsonResult)>0?getTradingList(context, jsonResult.data):Container();
        else
          return apiHandler(response: jsonResult);
      },
    );
  }

  Widget getTradingList(BuildContext context, var jsonResult) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(
            context: context,
            apiName: apiName,
            isShowViewAll: isShowViewAll(jsonResult)),
        SizedBox(height: 10),
        SizedBox(
          height: 190.0,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: getCount(jsonResult),
            itemBuilder: (context, index) {
              return getView(context, index, jsonResult);
            },
          ),
        ),
      ],
    );
  }

  int getCount(results) {
    if (results is NowPlayingRespo)
      return results.results.length;
    else if (apiName == StringConst.IMAGES && results is MovieImgRespo)
      return results.profiles.length;
    else if (results is MovieImgRespo)
      return results.backdrops.length;
    else
      return 0;
  }

  bool isShowViewAll(results) {
    if (results is NowPlayingRespo)
      return getCount(results) > 8 ? true : false;
    else if (apiName == StringConst.IMAGES && results is MovieImgRespo)
      return false;
    else if (results is MovieImgRespo)
      return false;
    else
      return true;
  }

  Widget getView(BuildContext context, int index, jsonResult) {
    if (jsonResult is MovieImgRespo) {
      var item;
      if (jsonResult.profiles != null && jsonResult.profiles.length > 0)
        item = jsonResult.profiles[index];
      else
        item = jsonResult.backdrops[index];
      String tag = getTitle(apiName) + item.filePath!=null ?item.filePath:'' + index.toString();
      return getLargeItem(
          context: context,
          img: ApiConstant.IMAGE_POSTER + item.filePath,
          tag: tag,
          onTap: () => navigationPush(
              context,
              FullImage(
                  jsonResult.profiles != null && jsonResult.profiles.length > 0
                      ? jsonResult.profiles
                      : jsonResult.backdrops,
                  index,
                  tag)));
    } else if (jsonResult is NowPlayingRespo) {
      Result item = jsonResult.results[index];
      String tag = getTitle(apiName) + item.poster_path + index.toString();
      return getLargeItem(
          context: context,
          img: ApiConstant.IMAGE_POSTER + item.poster_path,
          name: item.original_title,
          tag: tag,
          onTap: () => navigationPush(
              context, DetailsMovieScreen(apiName, index, item.id, tag)));
    } else
      Container(child: getTxt(msg: StringConst.NO_DATA_FOUND));
  }

//  getMovieImage(BuildContext context, MovieImgRespo results) {
//    return Column(
//      children: <Widget>[
//        SizedBox(height: 10),
//        getHeading(context: context, apiName: apiName, isShowViewAll: false),
//        SizedBox(height: 10),
//        SizedBox(
//          height: 190.0,
//          child: ListView.builder(
//            shrinkWrap: true,
//            scrollDirection: Axis.horizontal,
//            itemCount: results.backdrops.length,
//            itemBuilder: (context, index) {
//              var item = results.backdrops[index];
//              String tag = getTitle(apiName) + item.filePath + index.toString();
//              return getLargeItem(
//                  context: context,
//                  img: ApiConstant.IMAGE_POSTER + item.filePath,
//                  tag: tag,
//                  onTap: () => navigationPush(
//                      context, FullImage(results.backdrops, index, tag)));
//            },
//          ),
//        ),
//      ],
//    );
//  }
}

Widget getLargeItem(
    {@required BuildContext context,
    String img,
    String name,
    String tag,
    Function onTap}) {
  final size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
    child: Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: tag,
          child: Expanded(
            child: Stack(
              children: [
                Container(
                  height: 150,
                  width: size.width - 80,
                  child: ClipRRect(
                    child: Image.network(
                      img,
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
                          onTap: () => onTap(),
                        ))),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
        if (name != null)
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: getTxtBlackColor(
                  msg: name, fontSize: 15, fontWeight: FontWeight.w700)),
      ],
    )),
  );
}