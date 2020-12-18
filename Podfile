# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'
source 'https://gitee.com/devjackcat/JCS_PodSpecs.git'

install! 'cocoapods' #, generate_multiple_pod_projects: true

use_frameworks!

workspace 'swift-study.xcworkspace'

def app_foundation_depency
  pod 'SnapKit'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxRelay'
  pod 'Moya'
  pod 'Moya/RxSwift'
  pod 'HandyJSON'
  pod 'Closures'
  pod 'Kingfisher'
  pod 'ReactorKit'
  
  pod 'IGListKit'
  pod 'UITableView+FDTemplateLayoutCell'
  
end

target 'AppFoundation' do
  project 'AppFoundation/AppFoundation.xcodeproj'
  app_foundation_depency
end

target 'swift-study' do
  project 'swift-study.xcodeproj'
  
  app_foundation_depency
  
end
