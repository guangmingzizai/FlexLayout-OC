#
# Be sure to run `pod lib lint FlexLayout-OC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FlexLayout-OC'
  s.version          = '1.0.3'
  s.platform         = :ios, "8.0"
  s.summary          = 'FlexLayout-OC adds a nice Objective-C interface to the highly optimized facebook/yoga flexbox implementation. Concise, intuitive & chainable syntax.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
FlexLayout-OC adds a nice Objective-C interface to the highly optimized Yoga flexbox implementation. Concise, intuitive & chainable syntax.

Flexbox is an incredible improvement over UIStackView. It is simpler to use, much more versatile and amazingly performant.
                       DESC

  s.homepage         = 'https://github.com/guangmingzizai/FlexLayout-OC'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wangjianfei' => 'guangmingzizai@qq.com' }
  s.source           = { :git => 'https://github.com/guangmingzizai/FlexLayout-OC.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = "Sources/**/*.{swift,h,m,mm,cpp,c}"
  s.libraries    = 'c++'
  s.dependency 'YogaKit-GM'
  s.requires_arc = true

  
  # Should match yoga_defs.bzl + BUCK configuration
  s.compiler_flags = [
  '-fno-omit-frame-pointer',
  '-fexceptions',
  '-Wall',
  '-Werror',
  '-fPIC'
  ]
end
