import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/data/person/tranding_person_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/person/person_detail.dart';
import 'package:flutterarch/view/widget/movie_cast_crew.dart';
import 'package:flutterarch/view/widget/tranding_movie_row.dart';
import 'package:scoped_model/scoped_model.dart';

class TrandingPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: apiresponse(context));
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.trandingPersonRespo;
        if (jsonResult.status == ApiStatus.COMPLETED)
          return jsonResult.data.results.length > 0
              ? trandingPerson(context, jsonResult.data.results)
              : Container();
        else
          return apiHandler(response: jsonResult);
      },
    );
  }

  Widget trandingPerson(BuildContext context, List<Results> results) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(context: context, apiName: StringConst.TRANDING_PERSON_OF_WEEK),
        SizedBox(height: 8),
        getPersonItem(context, results)
      ],
    );
  }

  Widget getPersonItem(BuildContext context, List<Results> persons) {
    return Container(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: persons.length,
        itemBuilder: (context, index) {
          var item = persons[index];
          return Container(
            padding: EdgeInsets.only(top: 10.0),
            width: 100.0,
            child: castCrewItem(
              id: item.id,
              tag: 'tranding person' + index.toString(),
              name: item.name,
              image: item.profilePath,
              job: item.knownForDepartment,
              onTap: (int id) =>navigationPush(context, PersonDetail(id: item.id, imgPath: item.profilePath, tag: 'tranding person' + index.toString())))
//            InkWell(
//              onTap: () {
//                navigationPush(context, PersonDetail());
//              },
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  item.profilePath == null
//                      ? Hero(
//                          tag: item.id,
//                          child: Container(
//                            width: 80.0,
//                            height: 80.0,
//                            decoration: new BoxDecoration(
//                                shape: BoxShape.circle,
//                                color: ColorConst.APP_COLOR),
//                            child: Icon(
//                              Icons.person_pin,
//                              color: Colors.white,
//                            ),
//                          ),
//                        )
//                      : Hero(
//                          tag: item.id,
//                          child: Container(
//                              width: 80.0,
//                              height: 80.0,
//                              decoration: new BoxDecoration(
//                                shape: BoxShape.circle,
//                                image: new DecorationImage(
//                                    fit: BoxFit.cover,
//                                    image: NetworkImage(
//                                        ApiConstant.IMAGE_POSTER +
//                                            item.profilePath)),
//                              )),
//                        ),
//                  SizedBox(height: 5.0),
//                  getTxtBlackColor(
//                      msg: item.name,
//                      fontSize: 12,
//                      fontWeight: FontWeight.bold,
//                      maxLines: 1,
//                      textAlign: TextAlign.center),
//                  SizedBox(height: 3.0),
//                  getTxtBlackColor(
//                      msg: item.knownForDepartment,
//                      fontSize: 12,
//                      fontWeight: FontWeight.w600),
//                ],
//              ),
//            ),
          );
        },
      ),
    );
  }
}
