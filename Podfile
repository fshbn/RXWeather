platform :ios, '10.0'
use_frameworks!

target ‘RXWeather’ do
    pod 'RxSwift', '~> 3.0'
    pod 'RxCocoa', '~> 3.0'
end

target 'RXWeatherTests’ do
    pod 'Quick'
    pod 'Nimble'
    pod 'RxBlocking', '~> 3.0'
    pod 'RxTest',     '~> 3.0'
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
