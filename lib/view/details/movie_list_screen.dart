import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/assets_const.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';

class MovieListScreen extends StatefulWidget {

  MovieListScreen();

  @override
  _MovieListScreenState createState() =>
      _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {

  _MovieListScreenState();

  @override
  Widget build(BuildContext context) {
//    return
//      body: ScopedModel(model: model, child: apiresponse(model)));
    var homeIcon = IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorConst.BLACK_COLOR,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
    return Scaffold(
        appBar: getAppBarWithBackBtn(
            ctx: context,
            title: StringConst.HOME_TITLE,
            bgColor: Colors.white,
            icon: homeIcon),
        body: _createUi());
  }

  Widget _createUi() {
    final size = MediaQuery
        .of(context)
        .size;
    return Container(
//      width: double.infinity,
//      height: double.infinity,
        child: Container(
          alignment: Alignment.center,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                  },
                  child: Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 18.0 / 12.0,
                          child: Image.asset(
                            AssetsConst.PIZZA_IMG,
                            fit: BoxFit.cover,
                          ),
//              loadImg(ApiConst.DEMO_IMG, 0),
                        ),
                        new Padding(
                          padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                StringConst.TRANDING_MOVIE,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Color(0xFFD73C29),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'item.category',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 9.0,
                                ),
                              ),
                              SizedBox(height: 0.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 4.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'RELEASE DATE:',
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 9.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'item.releaseDate',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 9.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 4.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'RUNTIME:',
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 9.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'item.runtime',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 9.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
          ,
        ));
  }
}
