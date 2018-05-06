project 'WeatherApp/WeatherApp.xcodeproj'

platform :ios, '11.3'

target 'WeatherApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'Result'
  pod 'Moya', '~> 11.0.2'
  pod 'Swinject', '~> 2.4.0'

  target 'WeatherAppTests' do
    inherit! :search_paths
    
    pod 'Quick', '~> 1.3.0'
    pod 'Nimble', '~> 7.1.1'
    pod 'SwiftLint', '~> 0.25.1'
    pod 'Swinject', '~> 2.4.0'
  end

  target 'WeatherAppUITests' do
    inherit! :search_paths
  end
end
