import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/api_constant.dart';
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
  List<Story> _stories;

  @override
  void initState() {
    super.initState();
    _populateData();
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
//          getCategoryList(),
          getTradingList()
        ],
      ),
    );
  }

  Widget getCategoryList() {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _stories.length,
        itemExtent: 100.0,
        itemBuilder: (context, index) {
          var item = _stories[index];
          return getCatRow();
        },
      ),
    );
  }

  SizedBox getTradingList() {
    return SizedBox(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _stories.length,
        itemExtent: 100.0,
        itemBuilder: (context, index) {
          var item = _stories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    item.storyUrl,
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black26,
                    BlendMode.darken,
                  ),
                ),
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://iisy.fi/wp-content/uploads/2018/08/user-profile-male-logo.jpg',
                        ),
                        radius: 14.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item.name,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  void _populateData() {
    _stories = <Story>[
      Story(
          name: 'Hello',
          storyUrl:
          'https://images.unsplash.com/photo-1519501025264-65ba15a82390?ixlib=rb-1.2.1&w=1000&q=80'),
      Story(
          name: 'Waleed',
          storyUrl:
          'https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832__340.jpg'),
      Story(
          name: 'Flutter',
          storyUrl:
          'http://paranoidandroid.co/assets/wallpapers/2018/submerged_desktop_thumb.jpg'),
      Story(
          name: 'Flutter',
          storyUrl:
          'https://images.pexels.com/photos/799443/pexels-photo-799443.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
      Story(
          name: 'Flutter',
          storyUrl:
          'https://i.pinimg.com/originals/90/ff/c3/90ffc3cc0cfe33f1940d548a6c7602d1.jpg'),
      Story(
          name: 'Flutter',
          storyUrl:
          'https://images.pexels.com/photos/775201/pexels-photo-775201.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
    ];
  }
}

Widget getCatRow() {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: () {
//          navigationPush(context, ImageFolder(imageBean));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(4, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: Container(
              width: 120, child: loadImg(ApiConstant.DEMO_IMG, 0)),
        ),
      ),
    ),
  );
}
class Story {
  final String name;
  final String email;
  final String storyUrl;

  Story({this.name, this.storyUrl, this.email});
}
Widget getCarousel() {
  return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
//          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          autoPlay: true,
        ),
        items: imageSliders,
      )
  );
}
final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'No. ${imgList.indexOf(item)} image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )
    ),
  ),
)).toList();
