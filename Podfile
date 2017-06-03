platform :ios, '10.0'
use_frameworks!

def core_pods
    pod 'RxSwift', '~> 3.0'
    pod 'RxCocoa', '~> 3.0'
    pod 'SwiftLint'
    pod 'SwiftFormat/CLI'
    pod 'Alamofire', '~> 4.0'
    pod 'RxAlamofire'
    pod "RxCoreData", '~> 0.3.1'
    pod 'Reusable'
end

def test_pods
    pod 'Quick'
    pod 'Nimble'
    pod 'RxBlocking', '~> 3.0'
    pod 'RxTest',     '~> 3.0'
end

target ‘RXWeather’ do
    core_pods
end

target 'RXWeatherTests’ do
    test_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
            config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
        end
    end
end
