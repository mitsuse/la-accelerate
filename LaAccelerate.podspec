Pod::Spec.new do |spec|
  spec.name = 'LaAccelerate'
  spec.version = '0.7.0'
  spec.homepage = 'https://github.com/mitsuse/la-accelerate'
  spec.authors = {
    'Tomoya Kose' => 'tomoya@mitsuse.jp'
  }
  spec.summary = 'Matrix operations for La based on Apple\'s BLAS.'
  spec.source = { :git => 'https://github.com/mitsuse/la-accelerate.git' }
  spec.ios.deployment_target = '8.0'
  spec.source_files = 'Sources/**/*.swift'
  spec.dependency 'La', '~> 0.7.0'
end
