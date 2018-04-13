#
# Be sure to run `pod lib lint SwiftTableSpaces.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftTableSpaces'
  s.version          = '0.1.1'
  s.summary          = 'A modular approach to UITableViews.'
  s.swift_version    = '4'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  A modular approach to UITableViews. This framework wraps the UITableViewDataSource and UITableViewDelegate protocols and splits their functionality into smaller logically related protocols. This promotes more readable code and aims to aid in modularizing the sections of a UITableView, instead of handling all sections in one place. Splitting each section of a tableview into TableSpaces allows you to keep all of the functionality for a specific section separate from the other sections. TableSpaces can easily be tested and can be reused, subclassed or extended.
                       DESC

  s.homepage         = 'https://github.com/aj-bartocci/SwiftTableSpaces'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AJ Bartocci' => 'bartocci.aj@gmail.com' }
  s.source           = { :git => 'https://github.com/aj-bartocci/SwiftTableSpaces.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SwiftTableSpaces/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwiftTableSpaces' => ['SwiftTableSpaces/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
