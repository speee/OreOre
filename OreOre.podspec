#
# Be sure to run `pod lib lint OreOre.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OreOre'
  s.version          = '1.0.0'
  s.summary          = 'GraphQL UITest library'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.swift_version  =  '4.1'
  s.description      = <<-DESC
GraphQL UITest library.
this support mock data coding.
                       DESC

  s.homepage         = 'https://github.com/speee/OreOre'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'git' => 'hayato.iida.0213@gmail.com' }
  s.source           = { :git => 'https://github.com/speee/OreOre.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'

  s.source_files = 'Sources/**/*.swift'
  
  # s.resource_bundles = {
  #   'OreOre' => ['OreOre/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'Fakery'
  s.dependency 'Apollo'
  s.dependency 'Embassy'
  s.dependency 'EnvoyAmbassador'
end
