Pod::Spec.new do |s|
  s.name         = "CloverFly"
  s.version      = "1.0.0"
  s.summary      = "This is a ClvoerFly"
  s.description  = <<-DESC
                   This is a ClvoerFly and This is a ClvoerFly
                   DESC

  s.homepage     = "https://github.com/liwanren/CloverFly"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = "MIT"
  s.author             = { "Clover" => "lc1028@126.com" }


  s.source       = { :git => "https://github.com/liwanren/CloverFly.git", :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/NAME' 
  
  s.platform     = :ios, "6.0"
  
  s.requires_arc = true
  
 	s.source_files  = 'CloverFly/LxFileManager/**/*.{h,m,mm}
	s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit' 

end


s.subspec 'Security' do |ss|
    ss.source_files = 'CloverFly/LxCategory/**/*.{h,m,mm}
#    ss.frameworks = 'Security'
end