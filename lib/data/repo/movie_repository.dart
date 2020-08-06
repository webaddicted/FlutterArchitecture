import 'dart:convert';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/data/bean/comon_movie_req.dart';
import 'package:flutterarch/data/bean/movie_req.dart';
import 'package:flutterarch/data/bean/movie_respo.dart';
import 'package:flutterarch/data/home/movie_cat_respo.dart';
import 'package:flutterarch/data/home/now_playing_respo.dart';
import 'package:flutterarch/utils/apiutils/api_base_helper.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';

class MovieRepository {
  fetchMovieList() async {
    try {
      final response = await apiHelper.getWithParam(
          "${ApiConstant.POPULAR_MOVIES}",
          MovieReq(ApiConstant.API_KEY).toMap());
      return ApiResponse.returnResponse(
          response, MovieRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      return ApiResponse.error(
          errCode: ApiRespoCode.known,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
      data:null);
    }
  }

  fetchNowPlaying({String endPoint, int page})async {
    try {
      var commonReq ;
      if(page==null){
        commonReq = CommonMovieReq.empty().toJson();
      }else{
        commonReq = CommonMovieReq.page(page.toString()).toJson();
      }
      final response = await apiHelper.getWithParam(
          "${endPoint}",
      commonReq
      );
      return ApiResponse.returnResponse(
          response, NowPlayingRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      return ApiResponse.error(
          errCode: ApiRespoCode.known,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data:null);
    }
  }

  fetchMovieCat()async {
    try {
      final response = await apiHelper.getWithParam(
          "${ApiConstant.GENRES_LIST}",
          CommonMovieReq.empty().toJson()
      );
      return ApiResponse.returnResponse(
          response, MovieCatRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      return ApiResponse.error(
          errCode: ApiRespoCode.known,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data:null);
    }
  }

}
