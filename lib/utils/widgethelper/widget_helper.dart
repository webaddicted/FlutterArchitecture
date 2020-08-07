import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/assets_const.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';

//  {START PAGE NAVIGATION}
void navigationPush(BuildContext context, StatefulWidget route) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return route;
    },
  ));
}

void navigationPop(BuildContext context, StatefulWidget route) {
  Navigator.pop(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}

void navigationStateLessPush(BuildContext context, StatelessWidget route) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}

void navigationStateLessPop(BuildContext context, StatelessWidget route) {
  Navigator.pop(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}

void delay(BuildContext context, int duration, StatefulWidget route) {
  Future.delayed(const Duration(seconds: 3), () {
    navigationPush(context, route);
  });
}

//  {END PAGE NAVIGATION}



Widget apiHandler<T>(
    {ApiResponse<T> response, Widget loading , Widget error}) {
  switch (response.status) {
    case ApiStatus.LOADING:
      debugPrint("LOADING");
      return loading != null ? loading : Loading();
      break;
    case ApiStatus.ERROR:
      debugPrint("ERROR");
      return error != null
          ? error
          : Error(
              errorMessage: response.apierror.errorMessage,
              onRetryPressed: () {
                //call api
              },
            );
      break;
    default:
      {
        return Container(
          color: Colors.amber,
        );
      }
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.lightGreen,
            child: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "loadingMessage",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}

AppBar getAppBarWithBackBtn(
    {@required BuildContext ctx,
      String title,
      Color bgColor,
      double fontSize,
    Widget icon}) {
  return AppBar(
    backgroundColor: bgColor == null ? ColorConst.APP_COLOR : bgColor,
    leading: icon,
    centerTitle: true,
    title: new Text(
      title,
      style: new TextStyle(
          fontWeight: FontWeight.bold,color: Colors.black, fontSize: fontSize!=null ? fontSize : 16),
    ),
  );
}

//  {START TEXT VIEW}
Text getTxt({@required String msg, FontWeight fontWeight}) {
  return Text(msg,
      style: TextStyle(
          fontFamily: AssetsConst.ZILLASLAB_FONT,
          fontWeight: fontWeight == null ? FontWeight.normal : fontWeight));
}

Text getTxtAppColor(
    {@required String msg, double fontSize, FontWeight fontWeight}) {
  return Text(
    msg,
    style: _getFontStyle(
        txtColor: ColorConst.APP_COLOR,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text getTxtWhiteColor(
    {@required String msg, double fontSize, FontWeight fontWeight}) {
  return Text(
    msg,
    style: _getFontStyle(
        txtColor: Colors.white,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text getTxtBlackColor(
    {@required String msg, double fontSize, FontWeight fontWeight, int maxLine}) {
  return Text(
    msg,
    style: _getFontStyle(
        txtColor: Colors.black, fontSize: fontSize, fontWeight: fontWeight),
  );
}

Text getTxtGreyColor(
    {@required String msg, double fontSize, FontWeight fontWeight}) {
  return Text(
    msg,
    style: _getFontStyle(
        txtColor: ColorConst.GREY_COLOR,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text getTxtGreyCenterColor(
    {@required String msg, double fontSize, FontWeight fontWeight}) {
  return Text(
    msg,
    textAlign: TextAlign.center,
    style: _getFontStyle(
        txtColor: ColorConst.GREY_COLOR,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text getTxtWhiteCenterColor(
    {@required String msg, double fontSize, FontWeight fontWeight}) {
  return Text(
    msg,
    textAlign: TextAlign.center,
    style: _getFontStyle(
        txtColor: ColorConst.WHITE_COLOR,
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}

Text getTxtBlackCenterColor(
    {@required String msg, double fontSize, FontWeight fontWeight}) {
  return Text(
    msg,
    textAlign: TextAlign.center,
    style: _getFontStyle(
        txtColor: Colors.black, fontSize: fontSize, fontWeight: fontWeight),
  );
}

Text getTxtColor(
    {@required String msg,
      @required Color txtColor,
      double fontSize,
      FontWeight fontWeight}) {
  return Text(
    msg,
    textAlign: TextAlign.center,
    style: _getFontStyle(
        txtColor: txtColor, fontSize: fontSize, fontWeight: fontWeight),
  );
}

TextStyle _getFontStyle(
    {Color txtColor,
      double fontSize,
      FontWeight fontWeight,
      String fontFamily,
      TextDecoration txtDecoration}) {
  return TextStyle(
      color: txtColor,
      fontSize: fontSize!=null ? fontSize : 14,
      decoration: txtDecoration == null ? TextDecoration.none : txtDecoration,
      fontFamily: fontFamily == null ? AssetsConst.ZILLASLAB_FONT : fontFamily,
      fontWeight: fontWeight == null ? FontWeight.normal : fontWeight);
}

//  {END TEXT VIEW}

ClipRRect loadLocalCircleImg(String imagePath, double radius) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: new FadeInImage.assetNetwork(
        height: radius,
        width: radius,
        fit: BoxFit.fill,
        placeholder: imagePath,
        image: 'imgUrl'),
  );
}
FadeInImage loadImg(String url, int placeHolderPos) {
  return new FadeInImage.assetNetwork(
      fit: BoxFit.fill,
      placeholder: _getPlaceHolder(placeHolderPos),
      image: url);
}
ClipRRect loadCircleImg(String imgUrl, int placeHolderPos, double radius) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: new FadeInImage.assetNetwork(
        height: radius,
        width: radius,
        fit: BoxFit.fill,
        placeholder: _getPlaceHolder(placeHolderPos),
        image: imgUrl),
  );
}

String _getPlaceHolder(int placeHolderPos) {
  switch (placeHolderPos) {
    case 0:
      return AssetsConst.LOGO_IMG;
    default:
      return AssetsConst.LOGO_IMG;
  }
}

Widget getCacheImage(String url){
  return CachedNetworkImage(
    fit: BoxFit.cover,
    imageUrl: url,
    placeholder: (context, url) =>
    const CircularProgressIndicator(),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}

Divider getDivider() {
  return Divider(
    color: ColorConst.GREY_COLOR,
    height: 1,
  );
}



