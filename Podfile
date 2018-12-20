# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_modular_headers!
inhibit_all_warnings!

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

  target 'SwiftyRxVIPERTests' do
      pod 'Quick'
      pod 'Nimble'
  end
end

target 'SwiftyRxVIPER-Staging' do
  shared_pods
end


