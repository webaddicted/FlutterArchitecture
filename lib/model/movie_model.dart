import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/data/bean/now_playing_respo.dart';
import 'package:flutterarch/data/repo/movie_repository.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieScopeModel extends Model {
  MovieRepository _movieRepo;
  ApiResponse<NowPlayingRespo> _trandingMovieRespo;

  MovieScopeModel() {
    _movieRepo = MovieRepository();
    _trandingMovieRespo =  ApiResponse.loading();
  }

  ApiResponse<NowPlayingRespo> get getTrandingMovie => _trandingMovieRespo;

  trandingMovie(int pageSize) async {
    // _trandingMovieRespo = ApiResponse.loading();
    // notifyListeners();
    _trandingMovieRespo = await _movieRepo.fetchNowPlaying(
        endPoint: ApiConstant.TRENDING_MOVIE_LIST, page: pageSize);
    notifyListeners();
  }
}
