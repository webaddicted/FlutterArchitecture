import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/data/bean/movie_respo.dart';
import 'package:flutterarch/data/home/movie_cat_respo.dart';
import 'package:flutterarch/data/home/now_playing_respo.dart';
import 'package:flutterarch/data/repo/movie_repository.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieModel extends Model {
  MovieRepository _movieRepo;
  ApiResponse<MovieRespo> _movieListRespo;

  ApiResponse<NowPlayingRespo> _nowPlayingRespo;
  ApiResponse<NowPlayingRespo> _popularMovieRespo;
  ApiResponse<MovieCatRespo> _movieCatRespo;
  ApiResponse<NowPlayingRespo> _trandingMovieRespo;
  ApiResponse<NowPlayingRespo> _discoverMovieRespo;
  ApiResponse<NowPlayingRespo> _upcommingMovieRespo;
  ApiResponse<NowPlayingRespo> _topRatedMovieRespo;

  MovieModel() {
    _movieRepo = MovieRepository();
    _movieListRespo = ApiResponse();
    _nowPlayingRespo = ApiResponse();
    _popularMovieRespo = ApiResponse();
    _movieCatRespo = ApiResponse();
    _trandingMovieRespo = ApiResponse();
    _discoverMovieRespo = ApiResponse();
    _topRatedMovieRespo = ApiResponse();
  }

  ApiResponse<MovieRespo> get getJsonResonse => _movieListRespo;

  fetchMovieList() async {
    _movieListRespo = ApiResponse.loading();
    _movieListRespo = await _movieRepo.fetchMovieList();
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get nowPlayingRespo => _nowPlayingRespo;

  fetchNowPlaying() async {
    _nowPlayingRespo = ApiResponse.loading();
    notifyListeners();
    _nowPlayingRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.NOW_PLAYING);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get popularMovieRespo => _popularMovieRespo;

  fetchPopularMovie() async {
    _popularMovieRespo = ApiResponse.loading();
    notifyListeners();
    _popularMovieRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.POPULAR_MOVIES);
    notifyListeners();
  }

  ApiResponse<MovieCatRespo> get getMovieCat => _movieCatRespo;

  fetchMovieCat() async {
    _movieCatRespo = ApiResponse.loading();
    notifyListeners();
    _movieCatRespo = await _movieRepo.fetchMovieCat();
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get getTrandingMovie => _trandingMovieRespo;

  trandingMovie() async {
    _trandingMovieRespo = ApiResponse.loading();
    notifyListeners();
    _trandingMovieRespo = await _movieRepo.fetchNowPlaying(
        endPoint: ApiConstant.TRENDING_MOVIE_LIST);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get getDiscoverMovie => _discoverMovieRespo;

  discoverMovie() async {
    _discoverMovieRespo = ApiResponse.loading();
    notifyListeners();
    _discoverMovieRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.DISCOVER_MOVIE);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get getUpcommingMovie => _upcommingMovieRespo;

  upcommingMovie() async {
    _upcommingMovieRespo = ApiResponse.loading();
    notifyListeners();
    _upcommingMovieRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.UPCOMING_MOVIE);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get getTopRatedMovie => _topRatedMovieRespo;

  topRatedMovie() async {
    _topRatedMovieRespo = ApiResponse.loading();
    notifyListeners();
    _topRatedMovieRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.TOP_RATED);
    notifyListeners();
  }
}
