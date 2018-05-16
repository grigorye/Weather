[![](https://travis-ci.org/grigorye/Weather.svg?branch=master)](https://travis-ci.org/grigorye/Weather)
[![](https://codecov.io/gh/grigorye/Weather/branch/master/graph/badge.svg)](https://codecov.io/gh/grigorye/Weather)
[![](https://gitlab.com/grigorye/Weather/badges/master/pipeline.svg)](https://gitlab.com/grigorye/Weather/commits/master)

My attempt to build weather app utilizing clean architecture approaches and modern tools.

# Notes

1. (B)VIPER is the architecture of the app. See more on that in [Scenes README](./Modules/WeatherAppKit/WeatherAppKit/Scenes/README.md).

   Module tests are not there yet, sorry. Working on that.

2. UI implementation is heavily based on storyboards, view controller containment (both dynamic and static) and sometimes storyboard references. The containment reflects module structure of (B)VIPER. As result every view controller is either (not both):

   * *View* managing "leaf" view;
   * *ContainerView* managing some number of *opaque* child views (read: container view controller).

   Each such a view controller is an implementation of View in the corresponding module.

3. UI is not well thought-out, to say the least. Unfortunately it was not the highest priority so far, due to focus on other things.

4. At some places RxSwift is used to implement dynamic bindings. There's more room for that/some things (in terms of implementation) need to be switched to RxSwift to improve the performance.

5. City lookup is implemented via lookup in pre-packaged Core Data store built from city list json available at [OpenWeatherMap](http://bulk.openweathermap.org/sample/). 

6. City search by zip is not there yet. Though there's primitive UI solution for that.

# Post Checkout

Please note that CocoaPods are not checked in into the repository, so after checkout they need to be installed via the two following commands:

1. Install the compatible version of the *pod* tool into the source tree:

        bundle install

2. Install the compatible version of the pods using just installed pod tool:

        bundle exec pod install
