import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/data/home/now_playing_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:scoped_model/scoped_model.dart';

class CarouselView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: apiresponse());
  }
}

Widget apiresponse() {
  return ScopedModelDescendant<MovieModel>(
    builder: (context, _, model) {
      var jsonResult = model.nowPlayingRespo;
      if (jsonResult.status == ApiStatus.COMPLETED)
        return CarouselSlider.builder(
          itemCount: jsonResult.data.results.length,
          itemBuilder: (BuildContext context, int itemIndex) =>
              getSliderItem(jsonResult.data.results[itemIndex]),
          options: CarouselOptions(
            aspectRatio: 2.0,
//          enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            autoPlay: true,
          ),
        );
      else
        return apiHandler(response: jsonResult);
    },
  );
}

Widget getSliderItem(Result item) {
  return Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            SizedBox(
                width: double.infinity,
                child: getCacheImage(ApiConstant.IMAGE_POSTER + item.poster_path)),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  item.original_title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned.fill(
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.redAccent,
                      onTap: () => {},
                    ))),
          ],
        )),
  );
}
