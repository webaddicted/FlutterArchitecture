import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/assets_const.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/adapter/movie_list.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieModel model;

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    model.fetchMovieList();
  }

  @override
  Widget build(BuildContext context) {
//        body: ScopedModel(model: model, child: apiresponse(model)));
    var homeIcon = IconButton(
        icon: Icon(
          Icons.storage,
          color: ColorConst.WHITE_COLOR,
        ),
        onPressed: () {
//          Navigator.pop(context);
        });
    return Scaffold(
        appBar: getAppBarWithBackBtn(
            ctx: context, title: StringConst.HOME_TITLE, icon: homeIcon),
        body: _createUi());
  }

  Widget _createUi() {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getTxtBlackColor(msg: 'Hey,\nWelcome', fontSize: 22),
                loadLocalCircleImg(AssetsConst.LOGO_IMG, 40),
              ],
            ),
          ),
          SizedBox(height: 10),
          getCarousel(),
        ],
      ),
    );
  }
}

Widget getCarousel() {
  return Container();
}
