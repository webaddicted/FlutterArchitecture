import 'package:flutterarch/data/bean/movie_respo.dart';
import 'package:flutterarch/data/repo/movie_repository.dart';
import 'package:flutterarch/utils/apiutils/api_response.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieModel extends Model {
  MovieRepository _movieRepo;
  ApiResponse<MovieRespo> _movieListRespo;

  MovieModel() {
    _movieRepo = MovieRepository();
    _movieListRespo = ApiResponse();
  }

  ApiResponse<MovieRespo> get getJsonResonse => _movieListRespo;

  fetchMovieList() async {
    _movieListRespo = ApiResponse.loading();
    _movieListRespo = await _movieRepo.fetchMovieList();
    notifyListeners();
  }
}
