import 'package:flutterarch/constant/api_constant.dart';
import 'package:flutterarch/data/bean/movie_respo.dart';
import 'package:flutterarch/data/details/credits_crew_respo.dart';
import 'package:flutterarch/data/details/keyword_respo.dart';
import 'package:flutterarch/data/details/movie_details_respo.dart';
import 'package:flutterarch/data/details/video_respo.dart';
import 'package:flutterarch/data/home/movie_cat_respo.dart';
import 'package:flutterarch/data/home/now_playing_respo.dart';
import 'package:flutterarch/data/person/person_detail_respo.dart';
import 'package:flutterarch/data/person/person_img_respo.dart';
import 'package:flutterarch/data/person/person_movie_respo.dart';
import 'package:flutterarch/data/repo/movie_repository.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieModel extends Model {
  MovieRepository _movieRepo;
  ApiResponse<MovieRespo> _movieListRespo;
//    {START HOME PAGE API}
  ApiResponse<NowPlayingRespo> _nowPlayingRespo;
  ApiResponse<NowPlayingRespo> _popularMovieRespo;
  ApiResponse<MovieCatRespo> _movieCatRespo;
  ApiResponse<NowPlayingRespo> _trandingMovieRespo;
  ApiResponse<NowPlayingRespo> _discoverMovieRespo;
  ApiResponse<NowPlayingRespo> _upcommingMovieRespo;
  ApiResponse<NowPlayingRespo> _topRatedMovieRespo;
//    {END HOME PAGE API}
//    {START MOVIE DETAILS PAGE API}
  ApiResponse<MovieDetailsRespo> _movieDetailRespo;
  ApiResponse<CreditsCrewRespo> _movieCrewRespo;
  ApiResponse<KeywordRespo> _movieKeywordRespo;
  ApiResponse<VideoRespo> _movieVideoRespo;
  ApiResponse<NowPlayingRespo> _recommendMovieRespo;
  ApiResponse<NowPlayingRespo> _similarMovieRespo;
  ApiResponse<NowPlayingRespo> _keywordMovieListRespo;
//    {END MOVIE DETAILS PAGE API}
  ApiResponse<NowPlayingRespo> _trandingPersonRespo;
  ApiResponse<PersonDetailRespo> _personDetailRespo;
  ApiResponse<PersonMovieRespo> _personMovieRespo;
  ApiResponse<PersonImgRespo> _personImageRespo;


  MovieModel() {
//    {START HOME PAGE API}
    _movieRepo = MovieRepository();
    _movieListRespo = ApiResponse();
    _nowPlayingRespo = ApiResponse();
    _popularMovieRespo = ApiResponse();
    _movieCatRespo = ApiResponse();
    _trandingMovieRespo = ApiResponse();
    _discoverMovieRespo = ApiResponse();
    _topRatedMovieRespo = ApiResponse();
//    {END HOME PAGE API}
//    {START MOVIE DETAILS PAGE API}
    _movieDetailRespo = ApiResponse();
    _movieCrewRespo = ApiResponse();
    _movieKeywordRespo = ApiResponse();
    _movieVideoRespo = ApiResponse();
    _recommendMovieRespo = ApiResponse();
    _similarMovieRespo = ApiResponse();
    _keywordMovieListRespo = ApiResponse();
//    {END MOVIE DETAILS PAGE API}
    _trandingPersonRespo = ApiResponse();
    _personDetailRespo = ApiResponse();
    _personMovieRespo = ApiResponse();
    _personImageRespo = ApiResponse();
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

  ApiResponse<MovieDetailsRespo> get getMovieDetails => _movieDetailRespo;

  movieDetails(String movieId) async {
    _movieDetailRespo = ApiResponse.loading();
    notifyListeners();
    _movieDetailRespo =
    await _movieRepo.movieDetails(movieId);
    notifyListeners();
  }

  ApiResponse<CreditsCrewRespo> get getMovieCrew => _movieCrewRespo;

  movieCrewCast(String movieId) async {
    _movieCrewRespo = ApiResponse.loading();
    notifyListeners();
    _movieCrewRespo =
    await _movieRepo.movieCrewCast(movieId);
    notifyListeners();
  }
  ApiResponse<KeywordRespo> get getMovieKeyword => _movieKeywordRespo;

  movieKeyword(String movieId) async {
    _movieKeywordRespo = ApiResponse.loading();
    notifyListeners();
    _movieKeywordRespo =
    await _movieRepo.movieKeyword(movieId);
    notifyListeners();
  }
  ApiResponse<VideoRespo> get getMovieVideo => _movieVideoRespo;

  movieVideo(String movieId) async {
    _movieVideoRespo = ApiResponse.loading();
    notifyListeners();
    _movieVideoRespo =
    await _movieRepo.movieVideo(movieId);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get recommendMovieRespo => _recommendMovieRespo;

  fetchRecommendMovie(String movieId) async {
    _recommendMovieRespo = ApiResponse.loading();
    notifyListeners();
    _recommendMovieRespo =
    await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.MOVIE_DETAILS+movieId+ApiConstant.RECOMMENDATIONS_MOVIE);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get similarMovieRespo => _similarMovieRespo;

  fetchSimilarMovie(String movieId) async {
    _similarMovieRespo = ApiResponse.loading();
    notifyListeners();
    _similarMovieRespo =
    await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.MOVIE_DETAILS+movieId+ApiConstant.SIMILAR_MOVIES);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get keywordMovieListRespo => _keywordMovieListRespo;

  fetchKeywordMovieList(String keywordId) async {
    _keywordMovieListRespo = ApiResponse.loading();
    notifyListeners();
    _keywordMovieListRespo =
    await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.KEYWORDS_MOVIE_LIST+keywordId);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get trandingPersonRespo => _trandingPersonRespo;

  fetchTrandingPerson() async {
    _trandingPersonRespo = ApiResponse.loading();
    notifyListeners();
    _trandingPersonRespo =
    await _movieRepo.fetchTrandingPerson();
    notifyListeners();
  }

  ApiResponse<PersonDetailRespo> get personDetailRespo => _personDetailRespo;

  fetchPersonDetail() async {
    _personDetailRespo = ApiResponse.loading();
    notifyListeners();
    _personDetailRespo =
    await _movieRepo.fetchPersonDetail();
    notifyListeners();
  }

  ApiResponse<PersonMovieRespo> get personMovieRespo => _personMovieRespo;

  fetchPersonMovie(int personId) async {
    _personMovieRespo = ApiResponse.loading();
    notifyListeners();
    _personMovieRespo =
    await _movieRepo.fetchPersonMovie(personId);
    notifyListeners();
  }

  ApiResponse<PersonImgRespo> get personImageRespo => _personImageRespo;

  fetchPersonImage(int personId) async {
    _personImageRespo = ApiResponse.loading();
    notifyListeners();
    _personImageRespo =
    await _movieRepo.fetchPersonImage(personId);
    notifyListeners();
  }

}
