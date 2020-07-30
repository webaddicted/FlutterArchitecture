import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/widget/carousel_view.dart';
import 'package:flutterarch/view/widget/navig_drawer.dart';
import 'package:flutterarch/view/widget/sifi_movie_row.dart';
import 'package:flutterarch/view/widget/tranding_movie_row.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieModel model;

//  List<StoryBean> _stories;

  @override
  void initState() {
    super.initState();
//    _populateData();
    model = MovieModel();
//    model.fetchMovieList();
  }

  @override
  Widget build(BuildContext context) {
//        body: ScopedModel(model: model, child: apiresponse(model)));
    var homeIcon = IconButton(
        icon: Icon(
          Icons.storage,
          color: ColorConst.BLACK_COLOR,
        ),
        onPressed: () {
//          Navigator.pop(context);
        });
    return Scaffold(
        appBar: getAppBarWithBackBtn(
            ctx: context,
            title: StringConst.HOME_TITLE,
            bgColor: Colors.white,
            icon: homeIcon),
        drawer: Drawer(
          child: NavDrawerView(),
        ),
        body: _createUi());
  }

  Widget _createUi() {
    return SafeArea(
      child: Container(
//        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              CarouselView(),
              TrandingMovieRow("Tranding"),
              getCate(),
              TrandingMovieRow("category"),
              SifiMovieRow("animationName"),
              TrandingMovieRow("SiFi"),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCate() {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(StringConst.CATEGORY),
        SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return getCatRow();
                }),
          ),
        ),
      ],
    );
  }

  Widget getCatRow() {
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
                )
              ],
            ),
            getTxtBlackColor(msg: StringConst.SIFI, fontWeight: FontWeight.w700)
          ],
        ),
      ),
    );
  }

  Widget getHeading(String heading) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          getTxtBlackColor(
              msg: heading, fontSize: 19, fontWeight: FontWeight.w700),
          GestureDetector(
            onTap: () {},
            child: getTxtColor(
                msg: StringConst.VIEW_ALL,
                txtColor: Colors.blue,
                fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }

}
