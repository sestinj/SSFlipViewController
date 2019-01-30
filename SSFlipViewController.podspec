#
# Be sure to run `pod lib lint SSFlipViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SSFlipViewController'
  s.version          = '0.1.4'
  s.summary          = 'Animate flips between the two sides of a two sided view controller.'
  s.swift_version    = '4.2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SSFlipViewController is a subclass of UIViewController that contains two child view controllers. They are displayed on opposite sides of a view, which can be flipped between the two faces. SSFlipViewController can either be a view within another view controller, or take up an entire screen as a main view controller.
                       DESC

  s.homepage         = 'https://github.com/sestinj/SSFlipViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sestinj' => '33237525+sestinj@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/sestinj/SSFlipViewController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'src/*.swift'
  
  # s.resource_bundles = {
  #   'SSFlipViewController' => ['SSFlipViewController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
