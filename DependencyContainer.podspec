Pod::Spec.new do |s|
  s.name             = 'DependencyContainer'
  s.version          = '1.3.0'
  s.summary          = 'Simple Dependency Container for iOS Apps'
  s.homepage         = 'https://github.com/pikciu/Container'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tomasz Pikć' => 'tomasz.pikc@gmail.com' }
  s.source           = { :git => 'https://github.com/pikciu/Container.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.source_files     = 'Sources/**/*.swift'
  s.resource_bundles = {"DependencyContainer" => ["Sources/PrivacyInfo.xcprivacy"]}
  s.swift_versions   = '5.0'
end