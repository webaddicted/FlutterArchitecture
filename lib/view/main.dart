import 'package:flutter/material.dart';
import 'package:flutterarch/constant/assets_const.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/data/bean/movie_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/view/home/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConst.APP_NAME,
      debugShowCheckedModeBanner: false,
//      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        fontFamily: AssetsConst.ZILLASLAB_FONT,
        accentColor: ColorConst.APP_COLOR,
        accentColorBrightness: Brightness.light,
        primarySwatch: ColorConst.APP_COLOR,
      ),
      home: HomeScreen(),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Page2()),
              );
            },
            child: Hero(
                tag: "profile-image",
                child: CircleAvatar(
                  maxRadius: 100.0,
                  backgroundImage: NetworkImage(
                    "https://images.unsplash.com/flagged/photo-1566127992631-137a642a90f4",
                  ),
                )),
          ),
        ));
  }
}


class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Hero(
          tag: "profile-image",
          child: Container(
            width: double.infinity,
            height: 400.0,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/flagged/photo-1566127992631-137a642a90f4",
                    ),
                    fit: BoxFit.cover)),
          ),
        ));
  }
}



































//Widget _createUi() {
//  return ScopedModel(model: model, child: apiresponse(model)));;
//}
//
//Widget apiresponse(MovieModel appState) {
//  return ScopedModelDescendant<MovieModel>(
//    builder: (context, _, model) {
//      var jsonResult = model.getJsonResonse;
//      if (jsonResult.status == ApiStatus.COMPLETED)
//        return MovieList(movieList: jsonResult.data.results);
//      else
//        return apiHandler(response: jsonResult);
//    },
//  );
//}
//}