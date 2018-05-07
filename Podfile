workspace 'WeatherApp.xcworkspace'

platform :ios, '11.3'

use_frameworks!

def all_non_test_pods
  pod 'Result'
  pod 'Moya', '~> 11.0.2'
  pod 'Swinject', '~> 2.4.0'
  pod 'Then', '~> 2.3.0'
  pod 'SwiftLint', '~> 0.25.1'
  pod 'GZIP', '~> 1.2.1'
  pod 'RxSwift', '~> 4.1.2'
end

def all_test_pods
  pod 'Quick', '~> 1.3.0'
  pod 'Nimble', '~> 7.1.1'
end

target 'WeatherApp' do
  project 'Modules/WeatherApp/WeatherApp.xcodeproj'
  
  all_non_test_pods

  target 'WeatherAppTests' do
    inherit! :search_paths
    
    all_test_pods
  end

  target 'WeatherAppUITests' do
    inherit! :search_paths
  end
end

target 'OpenWeatherMapKit' do
  project 'Modules/OpenWeatherMapKit/OpenWeatherMapKit.xcodeproj'

  all_non_test_pods
  
  target 'OpenWeatherMapKitTests' do
    inherit! :search_paths
    
    all_test_pods
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |configuration|
      configuration.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
      configuration.build_settings['SWIFT_EXEC'] = '$(SRCROOT)/../Tools/SWIFT_EXEC-no-coverage'
    end
  end
end
