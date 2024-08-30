Pod::Spec.new do |s|
    s.name                  = 'MWLottiePlugin'
    s.version               = '0.2.4'
    s.summary               = 'Lottie plugin for MobileWorkflow on iOS.'
    s.description           = <<-DESC
    Lottie plugin for MobileWorkflow on iOS, containg Lottie related steps:
	- MWLottieStep
    DESC
    s.homepage              = 'https://www.mobileworkflow.io'
    s.license               = { :type => 'Copyright', :file => 'LICENSE' }
    s.author                = { 'Future Workshops' => 'info@futureworkshops.com' }
    s.source                = { :git => 'https://github.com/FutureWorkshops/MWLottiePlugin-iOS.git', :tag => "#{s.version}" }
    s.platform              = :ios
    s.swift_version         = '5'
    s.ios.deployment_target = '17.1'
    s.default_subspecs      = 'Core'
	
    s.subspec 'Core' do |cs|
        cs.dependency            'MobileWorkflow', '~> 2.1.29'
        cs.dependency            'lottie-ios', '~> 3.1.9'
        cs.source_files          = 'MWLottiePlugin/MWLottiePlugin/**/*.swift'
    end
end
