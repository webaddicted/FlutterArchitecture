import 'dart:convert';
import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/data/bean/movie_req.dart';
import 'package:flutterarch/data/bean/movie_respo.dart';
import 'package:flutterarch/utils/apiutils/api_base_helper.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';

class MovieRepository {
  fetchMovieList() async {
    try {
      final response = await apiHelper.getWithParam(
          "${ApiConstant.POPULAR_MOVIES}",
          Movie_req(ApiConstant.API_KEY).toMap());
      if (response.statusCode == ApiRespoCode.no_internet_connection)
        return ApiResponse.error(
            errCode: response.statusCode,
            errMsg: ApiConstant.NoInternetConnection,
            data:null);
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
}
