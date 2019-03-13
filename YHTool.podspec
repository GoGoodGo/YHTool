#
# Be sure to run `pod lib lint YHTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YHTool'
  s.version          = '1.1.7'
  s.summary          = 'Custom Tool.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Alamofire, Custom view, Extension, Multi-select picture.
                       DESC

  s.homepage         = 'https://github.com/GoGoodGo/YHTool'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'OYangHui' => '442371047@qq.com' }
  s.source           = { :git => 'https://github.com/GoGoodGo/YHTool.git', :tag => s.version.to_s }

  s.swift_version = '4.2'
  s.ios.deployment_target = '9.0'
  
  s.source_files = 'YHTool/Classes/**/*.{swift,h,m}'
  
  s.resource_bundles = {
      'YHTool' => ['YHTool/Classes/**/*.xib', 'YHTool/Assets/*.png']
  }
  
  #s.public_header_files = 'YHTool/Classes/**/*.h'
  
  s.frameworks = 'UIKit', 'Foundation'
  
  s.dependency 'Alamofire'
  s.dependency 'SwiftyJSON'
  s.dependency 'ObjectMapper'
  s.dependency 'AlamofireObjectMapper'
  s.dependency 'MBProgressHUD'
  s.dependency 'QBImagePickerController'
  s.dependency 'SDWebImage'
  
  
end
