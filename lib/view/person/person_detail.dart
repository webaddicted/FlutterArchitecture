import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/constant/string_const.dart';
import 'package:flutterarch/data/person/person_detail_respo.dart';
import 'package:flutterarch/model/movie_model.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:flutterarch/utils/widgethelper/widget_helper.dart';
import 'package:flutterarch/view/widget/sifi_movie_row.dart';
import 'package:scoped_model/scoped_model.dart';

class PersonDetail extends StatefulWidget {
  final id;
  final imgPath;
  final tag;

  PersonDetail({@required this.id, this.imgPath, this.tag});

  @override
  _PersonDetailState createState() => _PersonDetailState(id, imgPath, tag);
}

class _PersonDetailState extends State<PersonDetail> {
  final id;
  final imgPath;
  final tag;
  MovieModel model;

  _PersonDetailState(this.id, this.imgPath, this.tag);

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    model.fetchPersonDetail(id);
    model.fetchPersonImage(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScopedModel(model: model, child: apiresponse(context)));
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.personDetailRespo;
        if (jsonResult.status == ApiStatus.COMPLETED) {
          return _createUi(jsonResult.data);
        } else
          return apiHandler(response: jsonResult);
      },
    );
  }

  Widget _createUi(PersonDetailRespo data) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              expandedHeight: 330.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: getTxt(msg: data.name),
                background: Hero(
                    tag: tag,
                    child: CachedNetworkImage(
                      imageUrl: ApiConstant.IMAGE_ORIG_POSTER + imgPath,
                      fit: BoxFit.fill,
                    )),
              )),
          SliverList(
            delegate: SliverChildListDelegate([getContent(data)]),
          )
        ],
      ),
    );
  }

  Widget getContent(PersonDetailRespo data) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          personalInfo(data),
          SizedBox(height: 10),
          SifiMovieRow(StringConst.IMAGES),
//          SifiMovieRow(StringConst.IMAGES)
        ],
      ),
    );
  }

  Widget personalInfo(PersonDetailRespo data) {
    final size = MediaQuery.of(context).size;
    final _now = data.deathday != null
        ? DateTime.parse(data.deathday).year
        : DateTime.now().year;

    int yearold = _now - DateTime.parse(data.birthday).year;
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(height: 5),
          getTxtBlackColor(
              msg: StringConst.BIOGRAPHY,
              fontSize: 23,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.start),
          SizedBox(height: 15),
          getTxtGreyColor(
              msg: data.biography, fontSize: 15, fontWeight: FontWeight.w400),
          SizedBox(height: 15),
          getTxtBlackColor(
              msg: StringConst.PERSONAL_INFO,
              fontSize: 23,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.start),
          SizedBox(height: 5),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
              padding: EdgeInsets.all(10),
              width: size.width - 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getPIDetail('Gender', data?.gender == 2 ? 'Male' : 'Female'),
                  getPIDetail('Age', '$yearold years old'),
                  getPIDetail('Known For', data?.knownForDepartment ?? ''),
                  getPIDetail('Date of Birth','${data.birthday ?? ''}'),
                  getPIDetail('Birth Place','${data?.placeOfBirth ?? ''}'),
                  getPIDetail('Official Site', '${data?.homepage ?? '-'}'),
                  getPIDetail('Also Known As', data?.alsoKnownAs?.join(' , ') ?? '-'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getPIDetail(String hint, String detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTxtGreyColor(msg: hint, fontSize: 13, textAlign: TextAlign.start),
        SizedBox(height: 3),
        getTxtBlackColor(msg: detail, fontSize: 16, textAlign: TextAlign.start),
        SizedBox(height: 8),
        Divider(height: 2),
        SizedBox(height: 8),
      ],
    );
  }
}
