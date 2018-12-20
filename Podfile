# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

def shared_pods
    pod 'SwiftLint'
	pod 'Moya'
    pod 'SnapKit'

    pod 'RxSwift'
    pod 'RxCocoa'

    pod 'R.swift'
end

target 'SwiftyRxVIPER' do
  shared_pods
end

target 'SwiftyRxVIPERTests' do
  shared_pods
  pod 'Quick'
  pod 'Nimble'
end
