Pod::Spec.new do |s|  
  s.name              = 'Placeholder'
  s.version           = '0.0.3'
  s.summary           = 'Make placeholder views in your storyboard, add views or viewcontrollers later'

  s.author            = { 'Oleksii Horishnii' => 'oleksii.horishnii@gmail.com' }
  s.license           = { :type => 'WTFPL', :file => 'LICENSE' }
  s.homepage          = "https://github.com/NeedMoreDesu/Placeholder"

  s.platform          = :ios


  s.source = {
    :git => "https://github.com/NeedMoreDesu/Placeholder.git",
    :tag => "#{s.version}"
  }
  s.source_files = 'Placeholder/**/*.swift'
  s.ios.deployment_target = '8.0'

end
