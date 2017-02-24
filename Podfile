
platform :ios, ‘9.0’

use_frameworks!

target :Swift3Basics do

  pod 'Realm’,’~> 2.4.0’
  pod 'RealmSwift’,’~> 2.4.0’

  pod 'Alamofire' ,’~> 4.0’
  pod 'AlamofireObjectMapper’,’~> 4.0’
  pod 'AlamofireImage’,’~> 3.0’

  pod 'SwiftyJSON', :git =>'https://github.com/acegreen/SwiftyJSON.git',:branch => 'swift3'
  pod 'KeychainSwift’,’~> 7.0.0’
  pod 'ObjectMapper’,’~> 2.2.0’
  
  pod 'ReachabilitySwift', '~> 3'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = ‘3.0’
        end
    end
end
