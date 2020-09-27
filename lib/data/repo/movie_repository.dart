import 'dart:convert';

import 'package:flutterarch/data/bean/comon_movie_req.dart';
import 'package:flutterarch/data/bean/now_playing_respo.dart';
import 'package:flutterarch/utils/apiutils/api_base_helper.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';

class MovieRepository {


  fetchNowPlaying({String endPoint, int page}) async {
    try {
      var commonReq;
      if (page == null) {
        commonReq = CommonMovieReq.empty().toJson();
      } else {
        commonReq = CommonMovieReq.page(page.toString()).toJson();
      }
      final response = await apiHelper.getWithParam("${endPoint}", commonReq);
      return ApiResponse.returnResponse(
          response, NowPlayingRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      return ApiResponse.error(
          errCode: ApiRespoCode.known,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }
}
