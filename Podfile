workspace 'WeatherApp.xcworkspace'

platform :ios, '11.3'

# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

def all_non_test_pods
  pod 'Result'
  pod 'Moya', '~> 11.0.2'
  pod 'Swinject', '~> 2.4.0'
  pod 'Then', '~> 2.3.0'
  pod 'SwiftLint', '~> 0.25.1'
end

def all_test_pods
  pod 'Quick', '~> 1.3.0'
  pod 'Nimble', '~> 7.1.1'
end

target 'WeatherApp' do
  project 'WeatherApp/WeatherApp.xcodeproj'
  
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
  project 'OpenWeatherMapKit/OpenWeatherMapKit.xcodeproj'

  all_non_test_pods
  
  target 'OpenWeatherMapKitTests' do
    inherit! :search_paths
    
    all_test_pods
  end
end
