

Pod::Spec.new do |s|


  s.name         = "ZQLoopScrollView.podspec"
  s.version      = "0.0.1"
  s.summary      = "简单易用的 app 必备的图片轮播器组件,一行代码解决"

  s.description  = <<-DESC
                    A easy and convient cycle photo part.
                   DESC

  s.homepage     = "https://github.com/sevenOnClass/ZQLoopScrollView"
  s.license      = "MIT"
  s.author       = { "sevenOnClass" => "zhuangqi_888@126.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/sevenOnClass/ZQLoopScrollView.git", :tag => "0.0.2" }

  s.source_files  = "ZQLoopScrollView/ZQLoopScrollview/ZQLoopScrollview/*.{h,m}"

  s.dependency "AFNetworking", "~> 2.5.2"

end
