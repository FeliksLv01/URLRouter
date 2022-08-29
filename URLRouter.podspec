Pod::Spec.new do |s|
  s.name             = 'URLRouter'
  s.version          = '0.0.1'
  s.summary          = 'URLRouter'

  s.description      = <<-DESC
URLRouter
                       DESC

  s.homepage         = 'https://github.com/felikslv01/URLRouter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'felikslv' => 'felikslv@163.com' }
  s.source           = { :git => 'https://github.com/felikslv01/URLRouter.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'URLRouter/Classes/**/*'
  s.public_header_files = "URLRouter/Classes/**/*.h"
  s.frameworks = 'UIKit'
end
