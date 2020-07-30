import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/assets_const.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';

class DetailsMovieScreen extends StatefulWidget {
  final pizza_img;
  final index;

  DetailsMovieScreen(this.pizza_img, this.index);

  @override
  _DetailsMovieScreenState createState() =>
      _DetailsMovieScreenState(pizza_img, index);
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen> {
  final animName;
  final index;

  _DetailsMovieScreenState(this.animName, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _createUi());
  }

  Widget _createUi() {
    final size = MediaQuery.of(context).size;
    return Container(
//      width: double.infinity,
//      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Hero(
              tag: animName+index.toString(),
              child: Container(
                child: Container(
                  height:400,// size.height * 0.55,
                  child: Image.asset(
                    AssetsConst.PIZZA_IMG,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          DraggableScrollableSheet(
            maxChildSize: 1,
            initialChildSize: 0.6,
            minChildSize: 0.6,
            builder: (context, controller) {
              return SingleChildScrollView(
                controller: controller,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 24),
                      getTxtBlackColor(
                          msg: "About Recipe",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 4),
                      getTxtBlackColor(
                          msg: StringConst.DUMMY_TEXT, fontSize: 18),
                      SizedBox(height: 24),
                      getTxtBlackColor(
                          msg: "Cooking Method",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 4),
                      getTxtBlackColor(
                          msg: StringConst.DUMMY_TEXT, fontSize: 18),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
