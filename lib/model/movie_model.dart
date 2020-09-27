import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/data/bean/now_playing_respo.dart';
import 'package:flutterarch/data/repo/movie_repository.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieModel extends Model {
  MovieRepository _movieRepo;
  ApiResponse<NowPlayingRespo> _trandingMovieRespo;

  MovieModel() {
    _movieRepo = MovieRepository();
    _trandingMovieRespo = ApiResponse();
  }

  ApiResponse<NowPlayingRespo> get getTrandingMovie => _trandingMovieRespo;

  trandingMovie() async {
    _trandingMovieRespo = ApiResponse.loading();
    notifyListeners();
    _trandingMovieRespo = await _movieRepo.fetchNowPlaying(
        endPoint: ApiConstant.TRENDING_MOVIE_LIST);
    notifyListeners();
  }
}
