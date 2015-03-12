Pod::Spec.new do |spec|
  spec.name         = 'CircularProgressView'
  spec.version      = '1.0'
  spec.license      = 'MIT'
  spec.summary      = 'Simple Circular Progress View for iOS'
  spec.homepage     = 'https://github.com/mangofever/CircularProgressView'
  spec.author       = 'Mangofever'
  spec.source       = { :git => 'https://github.com/mangofever/CircularProgressView.git', :tag => '1.0' }
  spec.source_files = 'CircularProgressViewSample/CircularProgressView/*'
  spec.requires_arc = true
  spec.ios.deployment_target = '7.0'
  spec.platform 	= :ios, '7.0'
  spec.framework	= 'QuartzCore'
end