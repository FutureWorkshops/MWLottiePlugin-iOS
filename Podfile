source 'https://cdn.cocoapods.org/'
source 'https://github.com/FutureWorkshops/MWPodspecs.git'

workspace 'MWLottie'
platform :ios, '13.0'

inhibit_all_warnings!
use_frameworks!

project 'MWLottie/MWLottie.xcodeproj'
project 'MWLottiePlugin/MWLottiePlugin.xcodeproj'

abstract_target 'MWLottie' do
  pod 'MobileWorkflow'
  pod 'lottie-ios'
  #here you can add any extra dependencies that you need

  target 'MWLottie' do
    project 'MWLottie/MWLottie.xcodeproj'

    target 'MWLottieTests' do
      inherit! :search_paths
    end
  end

  target 'MWLottiePlugin' do
    project 'MWLottiePlugin/MWLottiePlugin.xcodeproj'

    target 'MWLottiePluginTests' do
      inherit! :search_paths
    end
  end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['PROVISIONING_PROFILE_SPECIFIER'] = ""
    end
  end
end
