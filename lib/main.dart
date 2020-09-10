import 'package:flutter/material.dart';
import 'package:flutterarch/constant/assets_const.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/utils/sp/sp_manager.dart';
import 'package:flutterarch/view/home/home_screen.dart';
import 'package:flutterarch/view/intro/intro_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getView();
  }

  Widget getView() {
    return MaterialApp(
      title: StringConst.APP_NAME,
      debugShowCheckedModeBanner: false,
     // darkTheme: ThemeData.dark(),
      theme: ThemeData(
        fontFamily: AssetsConst.ZILLASLAB_FONT,
        accentColor: ColorConst.APP_COLOR,
        accentColorBrightness: Brightness.light,
        primarySwatch: ColorConst.APP_COLOR,
      ),
      home: SPManager.getOnboarding() != null &&
              SPManager.getOnboarding().toString().length > 0
          ? HomeScreen()
          : IntroScreen(),
    );
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
