# Uncomment this line to define a global platform for your project
# platform :ios
# Uncomment this line if you're using Swift
use_frameworks!

workspace 'MojioSDK.xcworkspace'

target 'MojioSDK' do
    project 'MojioSDK.project'

    pod 'Alamofire', '~> 4.0'
    pod 'SwiftyJSON', '~> 3.0'
    pod 'ObjectMapper', '~> 2.0'
    pod 'RealmSwift', '~> 1.1'
    pod 'KeychainSwift', '~> 6.0'
    pod 'OHHTTPStubs/Swift', '~> 5.2'
    pod 'SwiftWebSocket', :git => 'https://github.com/tidwall/SwiftWebSocket', :branch => 'master', :tag => '2.6.4'

end

target 'MojioSDKTests' do
    project 'MojioSDK.project'
    pod 'OHHTTPStubs/Swift', '~> 5.2'
end

