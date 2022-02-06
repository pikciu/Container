#
# Be sure to run `pod lib lint DependencyContainer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DependencyContainer'
  s.version          = '1.0.0-RC'
  s.summary          = 'Simple Dependency Container for iOS Apps'
  s.homepage         = 'https://github.com/pikciu/Container'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tomasz Pikć' => 'tomasz.pikc@gmail.com' }
  s.source           = { :git => 'https://github.com/pikciu/Container.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Container.playground/Sources/Container/**/*'
  s.swift_versions   = '5.0'
end
