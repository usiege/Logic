#
# Be sure to run `pod lib lint LGCommonUIModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LGCommonUIModule'
  s.version          = '0.1.0'
  s.summary          = 'A short description of LGCommonUIModule.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/cooci_tz@163.com/LGCommonUIModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cooci_tz@163.com' => 'cooci_tz@163.com' }
  s.source           = { :git => 'https://github.com/cooci_tz@163.com/LGCommonUIModule.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'LGCommonUIModule/Classes/**/*'
  
#  s.resource_bundles = {
#    'LGCommonUIModule' => ['LGCommonUIModule/Classes/**/*.xib']
#  }
  
  # s.resource_bundles = {
  #   'LGCommonUIModule' => ['LGCommonUIModule/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.dependency 'AFNetworking'
  s.dependency 'Masonry'
  s.dependency 'LGMacroAndCategoryModule'
  
  s.prefix_header_contents = '#import "Masonry.h"','#import "UIKit+AFNetworking.h"','#import "LGMacros.h"'
  
  s.subspec 'LGErrorView' do |ss|
      ss.source_files = 'LGCommonUIModule/Classes/LGErrorView/*'
   end
  
  s.subspec 'LGToast' do |ss|
     ss.source_files = 'LGCommonUIModule/Classes/LGToast/*'
  end
  
  s.subspec 'LGLoading' do |ss|
     ss.source_files = 'LGCommonUIModule/Classes/LGLoading/*'
  end
  
  s.subspec 'LGSegmentedControl' do |ss|
     ss.source_files = 'LGCommonUIModule/Classes/LGSegmentedControl/*'
  end
  
  s.subspec 'LGShare' do |ss|
    ss.dependency 'LGCommonUIModule/LGToast'
    ss.source_files = 'LGCommonUIModule/Classes/LGShare/*'
  end
  
end
