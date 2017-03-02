
platform :ios, ‘9.0’

use_frameworks!

target :Swift3Basics do
    
  pod 'Realm’
  pod 'RealmSwift’
  pod 'Alamofire'
  pod 'AlamofireObjectMapper’
  pod 'AlamofireImage’
  pod 'SwiftyJSON'
  pod 'KeychainSwift’
  pod 'ObjectMapper’
  pod 'ReachabilitySwift'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = ‘3.0’
        end
    end
end
