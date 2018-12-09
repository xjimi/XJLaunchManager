Pod::Spec.new do |s|

  s.name          = "XJLaunchManager"
  s.version       = "0.0.1"
  s.summary       = "Management APP Launch process"
  s.homepage      = "https://github.com/xjimi/XJLaunchManager"
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = { "XJIMI" => "fn5128@gmail.com" }
  s.source        = { :git => "https://github.com/xjimi/XJLaunchManager.git", :tag => s.version.to_s }
  s.source_files  = "XJLaunchManager", "XJLaunchManager/**/*.{h,m}"
  s.requires_arc  = true
  s.frameworks    = 'Foundation', 'UIKit'
  s.ios.deployment_target = '9.0'

end