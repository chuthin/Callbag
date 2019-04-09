Pod::Spec.new do |spec|
  spec.name         = "Callbag"
  spec.version      = "0.2.0"
  spec.summary      = "An implement Callbag.js"
  spec.description  = "An implement Callbag.js with Swift"

  spec.homepage     = "https://github.com/chuthin/Callbag"
  spec.license      = "MIT"
  spec.author             = { "Chu Thin" => "thincv@live.com" }
  spec.platform     = :ios, "10.0"

  spec.source       = { :git => "https://github.com/chuthin/Callbag.git", :tag => "#{spec.version}" }

  spec.source_files  = "Callbag/**/*.{swift}"
  spec.framework  = "UIKit"
  # spec.framework  = "SomeFramework"
  # spec.dependency "JSONKit", "~> 1.4"
  spec.dependency "ActionKit"
end
