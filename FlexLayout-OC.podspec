#
# Be sure to run `pod lib lint FlexLayout-OC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FlexLayout-OC'
  s.version          = '0.1.0'
  s.summary          = 'A short description of FlexLayout-OC.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/guangmingzizai@qq.com/FlexLayout-OC'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'guangmingzizai@qq.com' => 'wangjianfei@yipingfang.com' }
  s.source           = { :git => 'https://github.com/guangmingzizai@qq.com/FlexLayout-OC.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = "Sources/**/*.{swift,h,m,mm,cpp,c}"
  s.public_header_files = "Sources/yoga/{Yoga,YGEnums,YGMacros}.h", "Sources/YogaKit/{UIView+Yoga,YGLayout}.h"
  s.libraries    = 'c++'
  s.dependency 'YogaKit', '~> 1.7'

  
  # Should match yoga_defs.bzl + BUCK configuration
  s.compiler_flags = [
  '-fno-omit-frame-pointer',
  '-fexceptions',
  '-Wall',
  '-Werror',
  '-fPIC'
  ]
end
