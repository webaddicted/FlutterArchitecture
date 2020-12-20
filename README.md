# Flutter Architecture

Flutter architecture is architecture for flutter with help of Scope model.

[![GitHub license](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)
![Github Followers](https://img.shields.io/github/followers/webaddicted?label=Follow&style=social)
![GitHub stars](https://img.shields.io/github/stars/webaddicted/Flutter-Movies4U?style=social)
![GitHub forks](https://img.shields.io/github/forks/webaddicted/Flutter-Movies4U?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/webaddicted/Flutter-Movies4U?style=social)

## Component Used

  * Scope Model
  * Dio
  * Cache Image
  * Shimmer
  * Custom Fonts
  
## Apk

***You can Install and test latest Kotlin Demo app from below 👇***

[![Flutter Architecture](https://img.shields.io/badge/Flutter%20-Architecture-brightgreen.svg?style=for-the-badge&logo=android)](https://github.com/webaddicted/Flutter-architecture/tree/master/apk/flutterarch.apk)


## ScreenShot

<img src="screenshot/home.jpg" width="250">    <img src="screenshot/arch.gif" width="250">

 <img src="screenshot/home_land.jpg" width="600">

### Repository File

     fetchNowPlaying({String endPoint, int page}) async {
       try {
         var commonReq = CommonMovieReq.page(page.toString()).toJson();
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
    
### Model File

       trandingMovie(int pageSize) async {
          _trandingMovieRespo = ApiResponse.loading();
          notifyListeners();
          _trandingMovieRespo = await _movieRepo.fetchNowPlaying(
              endPoint: ApiConstant.TRENDING_MOVIE_LIST, page: pageSize);
          notifyListeners();
       }
 ## Flow Diagram
 
 
<img src="screenshot/arch.png" height="500">


<img src="screenshot/scope.png" height="600">
   
   
   
### View(UI)
            @override
        Widget build(BuildContext context) {
          var homeIcon = IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: ColorConst.BLACK_COLOR,
              ),
              onPressed: () => SystemNavigator.pop());
          return WillPopScope(
              onWillPop: () {
                return onWillPop(context);
              },
              child: Scaffold(
                  appBar: getAppBarWithBackBtn(
                      ctx: context,
                      title: 'Trending Movie',
                      bgColor: Colors.white,
                      icon: homeIcon,
                    ),
                  body: OrientationBuilder(
                      builder: (context, orientation) => ScopedModel(
                          model: model, child: apiresponse(orientation)))));
        }

        Widget apiresponse(Orientation orientation) {
          return ScopedModelDescendant<MovieScopeModel>(
            builder: (context, _, model) {
              var jsonResult = model.getTrandingMovie;
              if (jsonResult.status == ApiStatus.COMPLETED) {
                return _createUi(jsonResult.data, orientation);
              } else
                return apiHandler(
                    loading: RowMoviesScreen(
                      isShowShimmer: true,
                    ),
                    response: jsonResult);
            },
          );
        }


        
## LICENSE
```


                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/

             TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

```


