# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_modular_headers!
inhibit_all_warnings!

def shared_pods
    pod 'SwiftLint'
	pod 'Moya'
    pod 'Moya/RxSwift'
    pod 'SnapKit'
    pod 'SDWebImage'

    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxOptional'
    pod 'RxDataSources'

    pod 'R.swift'

    pod 'SVProgressHUD'
end

target 'SwiftyRxMVVM' do
  shared_pods

  target 'SwiftyRxMVVMTests' do
      pod 'Quick'
      pod 'Nimble'
  end
end

target 'SwiftyRxMVVM-Staging' do
  shared_pods
end


