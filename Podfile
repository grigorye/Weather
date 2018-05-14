workspace 'WeatherApp.xcworkspace'

platform :ios, '11.3'

use_frameworks!

def shared_non_test_pods
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
  
  shared_non_test_pods

  pod 'RxDataSources'
  pod 'RxCocoa'
  pod 'RxCoreData'

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

  shared_non_test_pods
  
  target 'OpenWeatherMapKitTests' do
    inherit! :search_paths
    
    all_test_pods
  end
end

target 'GenerateOpenWeatherMapPersistentCityInfos' do
  project 'Modules/OpenWeatherMapKit/OpenWeatherMapKit.xcodeproj'

  platform :osx, '10.13'

  shared_non_test_pods
end

post_install do |installer|
  # Patch RxSwift for RepeatWhen
  installer.pods_project.targets.each do |target|
    if target.name =~ /^RxSwift-iOS/
      puts("Adding RepeatWhen to RxSwift")
      group = target.project.main_group.find_subpath("Pods/RxSwift", true)
      file_ref = group.new_reference("../../Pods-Extras/RxSwift/RepeatWhen.swift")
      target.add_file_references([file_ref])
    end
  end
  # Enforce support for macOS for everything.
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |configuration|
      configuration.build_settings['CONFIGURATION_BUILD_DIR'] = '${PODS_CONFIGURATION_BUILD_DIR}'
      if target.name =~ /^Pods-/
        configuration.build_settings['SUPPORTED_PLATFORMS'] = 'iphoneos iphonesimulator macosx'
        configuration.build_settings['VALID_ARCHS'] = 'arm64 armv7 armv7s i386 x86_64'
      end
      xcconfig_path = configuration.base_configuration_reference.real_path
      xcconfig = Xcodeproj::Config.new(xcconfig_path).to_hash

      #
      frameworkSearchPaths = xcconfig['FRAMEWORK_SEARCH_PATHS']
      if frameworkSearchPaths == "XXX" && xcconfig_path.basename.to_s =~ /(debug|release).xcconfig$/
        puts(frameworkSearchPaths)
        macosFrameworkSearchPaths = frameworkSearchPaths.gsub(/"(\$\{PODS_CONFIGURATION_BUILD_DIR\}\/[.a-zA-Z0-9_-]+)-iOS"( |$)/, '"\1-macOS"\2')

        xcconfig['FRAMEWORK_SEARCH_PATHS'] = ''
        xcconfig['FRAMEWORK_SEARCH_PATHS[sdk=iphoneos*]'] = frameworkSearchPaths
        xcconfig['FRAMEWORK_SEARCH_PATHS[sdk=iphonesimulator*]'] = frameworkSearchPaths
        xcconfig['FRAMEWORK_SEARCH_PATHS[sdk=macosx*]'] = macosFrameworkSearchPaths
      end

      #
      # Remove framework search paths not existing when building (dynamic) frameworks
      #
      frameworkSearchPaths = xcconfig['FRAMEWORK_SEARCH_PATHS']
      if frameworkSearchPaths != nil
        frameworkSearchPaths = frameworkSearchPaths.gsub(/"\$\{PODS_CONFIGURATION_BUILD_DIR\}\/[.a-zA-Z0-9_-]+"( |$)/, '')
        xcconfig['FRAMEWORK_SEARCH_PATHS'] = frameworkSearchPaths
      end


      File.open(xcconfig_path, "w") { |file|
        xcconfig.each do |key,value|
          file.puts "#{key} = #{value}"
        end
      }
    end
  end
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |configuration|
      #configuration.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
      #configuration.build_settings['SWIFT_EXEC'] = '$(SRCROOT)/../Tools/SWIFT_EXEC-no-coverage'
    end
  end
end
