#
# Be sure to run `pod lib lint NarratiiveSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NarratiiveSDK'
  s.version          = '0.2.1'
  s.summary          = 'Narratiive Data Analytics IOS SDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is the IOS SDK for Narratiive App Trafic API.
                       DESC

  s.homepage         = 'https://github.com/covalercom/narratiive-analytics-iossdk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'git' => 'engineering@narratiive.com' }
  s.source           = { :git => 'https://github.com/covalercom/narratiive-analytics-iossdk.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'NarratiiveSDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NarratiiveSDK' => ['NarratiiveSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.swift_version = '4.0'
end
