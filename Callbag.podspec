#
# Be sure to run `pod lib lint Callbag.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Callbag'
  s.version          = '0.1.0'
  s.summary          = '👜 A standard for Swift callbacks that enables lightweight observables and iterables.'


  s.description      = '👜 A standard for Swift callbacks that enables lightweight observables and iterables.'

  s.homepage         = 'https://github.com/chuthin/Callbag/'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chuthin' => 'thincv@live.com' }
  s.source           = { :git => 'https://github.com/chuthin/Callbag.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/dev_phone'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Callbag/Classes/**/*'

  s.frameworks = 'UIKit' 
  s.dependency 'ActionKit'
  # s.resource_bundles = {
  #   'Callbag' => ['Callbag/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
