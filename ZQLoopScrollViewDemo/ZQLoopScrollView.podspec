

Pod::Spec.new do |s|


  s.name         = "ZQLoopScrollView"
  s.version      = "1.0.2"
  s.summary      = "简单易用的 app 必备的图片轮播器组件,一行代码解决"

  s.description  = <<-DESC
                    A easy and convient cycle photo part.
                   DESC

  s.homepage     = "https://github.com/sevenOnClass/ZQLoopScrollView"
  s.license      = "MIT"
  s.author       = { "sevenOnClass" => "zhuangqi_888@126.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/sevenOnClass/ZQLoopScrollView.git", :tag => s.version }

  s.source_files  = "ZQLoopScrollViewDemo/ZQLoopScrollView/ZQLoopScrollView/*.{h,m}"
  s.requires_arc = true
  s.dependency "AFNetworking", "~> 2.6.3"

end
