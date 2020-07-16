require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-ad"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-ad
                   DESC
  s.homepage     = "https://github.com/haxibiao/react-native-ad"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = { "ivan" => "ivan@haxibiao.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/haxibiao/react-native-ad.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"
  # ...
  # s.dependency "..."

  s.dependency 'Bytedance-UnionAD'
end

