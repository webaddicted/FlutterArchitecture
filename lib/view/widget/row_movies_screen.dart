import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/widget/rating_result.dart';

class RowMoviesScreen extends StatelessWidget {
  BuildContext context;
  String apiName;
  int index;
  double height;
  double width;
  int id;
  String img;
  String name;
  var vote;
  Function onTap;
  bool isShowShimmer = true;

  RowMoviesScreen(
      {this.context,
      this.apiName,
      this.index,
      this.height,
      this.width,
      this.id,
      this.img,
      this.name,
      this.vote,
      this.onTap,
      @required this.isShowShimmer});

  @override
  Widget build(BuildContext context) {
    if (isShowShimmer)
      return getMovieGridShimmer();
    else
      return getMovieItemRow();
  }

  Widget getMovieItemRow() {
    String tag = 'Trending Movies';
    return Hero(
      tag: tag,
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
                        url: ApiConstant.IMAGE_POSTER + img.toString(),
                        height: height),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Positioned.fill(
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Colors.redAccent,
                            onTap: () => onTap()))),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: getTxtBlackColor(
                    msg: name,
                    maxLines: 1,
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
                RatingResult(vote, 12.0),
                SizedBox(width: 5),
                RatingBar(
                  itemSize: 12.0,
                  initialRating: vote / 2,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: _getBackgrountRate(vote),
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
    );
  }

  Color _getBackgrountRate(var rate) {
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

  Widget getMovieGridShimmer() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              rowMovieGridShimmer(240, 155),
              rowMovieGridShimmer(240, 155),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              rowMovieGridShimmer(240, 155),
              rowMovieGridShimmer(240, 155),
            ],
          ),
        ],
      ),
    );
  }

  Widget rowMovieGridShimmer(double height, double width) {
    return Container(
      margin: EdgeInsets.all(5),
      width: width,
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: double.infinity,
              height: height,
              color: ColorConst.GREY_SHADE,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 100,
                height: 8,
                color: ColorConst.GREY_SHADE,
              )),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 70,
                height: 8,
                color: ColorConst.GREY_SHADE,
              )),
        ],
      ),
    );
  }
}
