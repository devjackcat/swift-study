# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'
source 'https://gitee.com/devjackcat/JCS_PodSpecs.git'

install! 'cocoapods' #, generate_multiple_pod_projects: true

use_frameworks!

workspace 'swift-study.xcworkspace'

def app_foundation_depency
  pod 'SnapKit'
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '~> 5.0'
  pod 'Moya/RxSwift', '~> 14.0.0-alpha.1'
  pod 'HandyJSON', '~> 5.0.3-beta'
  pod 'Closures'
  pod 'Then'
  pod 'Kingfisher'
  pod 'ReactorKit'
  pod 'URLNavigator'
  
  pod 'Cache'
  pod 'SwiftyAttributes'
  pod 'GzipSwift'
  
  pod 'IGListKit'
  pod 'UITableView+FDTemplateLayoutCell'
  
#  pod 'TinyConsole', :git => 'https://gitee.com/winddpan/TinyConsole', :configurations => ['Debug', 'DevelopArchive']
  pod 'TinyConsole', :git => 'https://gitee.com/winddpan/TinyConsole', :configurations => ['Debug']
  
  pod 'Result'
  pod 'NIMSDK_LITE'
  
end

target 'AppFoundation' do
  project 'AppFoundation/AppFoundation.xcodeproj'
  app_foundation_depency
end

target 'swift-study' do
  project 'swift-study.xcodeproj'
  
  app_foundation_depency
  
  target 'OrderModule'
  target 'PersonModule'
  
end
