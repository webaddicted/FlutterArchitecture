import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';

class PersonDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "movieTitle",
                  ),
                  background: Hero(
                      tag: "heroImageTag",
                      child: CachedNetworkImage(
                        imageUrl: ApiConstant.DEMO_IMG,
                        fit: BoxFit.fitHeight,
                      )),
                )),
            SliverList(
              delegate: SliverChildListDelegate(
                  [getContent()]),
            )
          ],
        ),
      ),
    );
  }

  Widget getContent() {
    return Container(
      child: Column(
        children: [
          getTxtAppColor(msg: StringConst.DUMMY_TEXT),
          getTxtAppColor(msg: StringConst.DUMMY_TEXT),
          getTxtAppColor(msg: StringConst.DUMMY_TEXT),
          getTxtAppColor(msg: StringConst.DUMMY_TEXT),
          getTxtAppColor(msg: StringConst.DUMMY_TEXT),
          getTxtAppColor(msg: StringConst.DUMMY_TEXT),
          getTxtAppColor(msg: StringConst.DUMMY_TEXT),
          getTxtAppColor(msg: StringConst.DUMMY_TEXT),
        ],
      ),
    );
  }
}
