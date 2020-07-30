import 'package:flutter/cupertino.dart';
import 'package:flutterarch/constant/color_const.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/category/category_screen.dart';

class NavDrawerView extends StatelessWidget {
   BuildContext _context;
  @override
  Widget build(BuildContext context) {
    this._context = context;
    return _drawerView();
  }
  Widget _drawerView() {

    return new Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 50)),
            loadCircleImg(
                "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
                0,
                140),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              "Deepak Sharma",
              style: TextStyle(
                  color: ColorConst.APP_COLOR,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 30)),
                _getDrawerItem("Home"),
                getDivider(),
                _getDrawerItem("Cart"),
                getDivider(),
                _getDrawerItem("Profile"),
                getDivider(),
                _getDrawerItem("Settings"),
                getDivider(),
                _getDrawerItem("Contact us"),
                getDivider(),
                _getDrawerItem("About us"),
                getDivider(),
                _getDrawerItem("exit"),
                getDivider(),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _getDrawerItem(String title) {
    return GestureDetector(
      onTap: () {
        _navigateOnNextScreen(title);
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: double.infinity,
          child: Padding(
            padding:
            EdgeInsets.only(top: 17.0, bottom: 17.0, left: 10.0, right: 3.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateOnNextScreen(String title) {
//    switch(title){
//      case "Home":
    Navigator.of(_context).pop();
    navigationPush(_context, CategoryMovie());
//        break;
//    }
  }
}