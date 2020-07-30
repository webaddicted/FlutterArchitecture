import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/assets_const.dart';
import 'package:flutterarch/data/bean/story_bean.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/details/detail_movie.dart';

class TrandingMovieRow extends StatelessWidget {
  final animationName;
  TrandingMovieRow(this.animationName);

//  List<String> imgList;
//  CarouselView(this.imgList);

  @override
  Widget build(BuildContext context) {
    return getTradingList();
  }

  SizedBox getTradingList() {
    return SizedBox(
      height: 190.0,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _populateData().length,
        itemBuilder: (context, index) {
          var item = _populateData()[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: GestureDetector(
              onTap: () {
                navigationPush(
                    context, DetailsMovieScreen(animationName, index));
//                  Navigator.push(context, MaterialPageRoute(
//                      builder: (context) => DetailsMovieScreen(AssetsConst.PIZZA_IMG)
//                  ));
              },
              child: Expanded(
          child:Hero(
                tag: animationName+index.toString(),
                child: Container(
                  child: ClipRRect(
                    child: Image.asset(
                      AssetsConst.PIZZA_IMG,
                      fit: BoxFit.cover,
                      width: 125,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              ),
            ),
//                tag: AssetsConst.PIZZA_IMG,
          );
        },
      ),
    );
  }

  List<StoryBean> _populateData() {
    var _stories = <StoryBean>[
      StoryBean(
          name: 'Hello',
          storyUrl:
              'https://images.unsplash.com/photo-1519501025264-65ba15a82390?ixlib=rb-1.2.1&w=1000&q=80'),
      StoryBean(
          name: 'Waleed',
          storyUrl:
              'https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832__340.jpg'),
      StoryBean(
          name: 'Flutter',
          storyUrl:
              'http://paranoidandroid.co/assets/wallpapers/2018/submerged_desktop_thumb.jpg'),
      StoryBean(
          name: 'Flutter',
          storyUrl:
              'https://images.pexels.com/photos/799443/pexels-photo-799443.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
      StoryBean(
          name: 'Flutter',
          storyUrl:
              'https://i.pinimg.com/originals/90/ff/c3/90ffc3cc0cfe33f1940d548a6c7602d1.jpg'),
      StoryBean(
          name: 'Flutter',
          storyUrl:
              'https://images.pexels.com/photos/775201/pexels-photo-775201.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
    ];
    return _stories;
  }
}