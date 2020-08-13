Pod::Spec.new do |s|
  
  s.name         = "MBasis"
  s.version      = "1.0.0"
  s.summary      = "MBasis SDK."
  s.description  = "MBasis SDK for iOS."
  
  s.homepage     = "http://www.yunduoketang.com"
  s.license      = "MIT"
  s.author       = { 'dxj' => 'qq@163.com' }

  s.platform     = :ios, "11.0"
  s.ios.deployment_target = "11.0"
  

  s.source       = { :git => 'https://github.com/dongMan/dxjRouter.git', :tag => s.version.to_s }

  s.requires_arc = true
  s.static_framework = true
  s.swift_version = '5.0'
  s.prefix_header_contents = <<-DESC
  
  DESC
  
  s.pod_target_xcconfig = {
    "GCC_PREPROCESSOR_DEFINITIONS" => "$(inherited) MBasis_NAME=#{s.name} MBasis_VERSION=#{s.version}"
  }
  
  #一个subspec的数组，该数组将作为优先依赖的subspec进行提供，如果没有指定，则spec要求全部subspec为依赖项。
  s.default_subspecs = ["SubBasis"]
  
  #Basis组件
  s.subspec 'SubBasis' do |ss|
  
        ### Base
        ss.subspec "Base" do |sss|
          sss.source_files = ["Foundation/**/*.{h,m}", "UIKit/**/*.{h,m}"]
          sss.public_header_files = [ "Foundation/**/*.h", "UIKit/**/*.h"]
          sss.frameworks = ["Foundation", "UIKit"]
          sss.libraries = ['icucore', 'c++']
        end
        
        ### MBaseSDK
        ss.subspec "MBaseSDK" do |sss|
          sss.public_header_files =
          "MBaseSDK/**/*.h"
          
          sss.source_files =
          "MBaseSDK/*.{h,m,swift}",
          "MBaseSDK/**/*.{h,m,swift}"
          
          sss.frameworks = "OpenAL", "GLKit"
          sss.libraries = "iconv", "z", "sqlite3"
          
          sss.dependency 'FFToast', '1.2.0'
          sss.dependency 'MBProgressHUD'
          sss.dependency 'LKDBHelper', '2.5.1'
        end
    
        ### MConfig
        ss.subspec "MConfig" do |sss|
          sss.source_files  = "MConfig/*.swift"
        end
        
        ### Protocol
        ss.subspec "Protocol" do |sss|
          sss.source_files  = "Protocol/*.swift"
        end
        
        ### CTMediatorFile
        ss.subspec "CTMediatorFile" do |sss|
          sss.public_header_files = "CTMediatorFile/*.h"
          sss.source_files = "CTMediatorFile/*.{h,m,swift}"
          
          sss.dependency 'CTMediator'
        end
    
        ### MColor
        ss.subspec "MColor" do |sss|
          sss.source_files  = "MColor/*.swift"
        end
        
        ### Network
        ss.subspec "Network" do |sss|
          sss.public_header_files =
          "Network/**/*.h"
          
          sss.source_files =
          "Network/**/*.{h,m,swift}"
          
          ### 网络 解析
          sss.dependency 'AFNetworking'
          sss.dependency 'HandyJSON', '~> 5.0.0'
          sss.dependency 'Alamofire', '~> 4.8.2'
          
          ### socket
          sss.dependency 'Socket.IO-Client-Swift', '13.2.1'
          
          sss.dependency 'Reachability'
          sss.dependency 'MBaseSDK' #MBasis.podspec 下的MBasis 下的MBaseSDK
          
        end

        ### SSL
        ss.subspec "SSL" do |sss|
          sss.public_header_files = "SSL/*.h"
          sss.source_files = "SSL/*.{h,m}"
        end
    
  end
  
  ###YS 这只是一个测试库 用来测试组件化集成其他sdk是否有问题
  s.subspec "YSSDK" do |ss|
        ss.resources = "YSLib_2.8.2.0/YSMeetingResources.bundle",
          "YSLib_2.8.2.0/YSResources.bundle",
          "YSLib_2.8.2.0/YSSkinRsource.bundle",
          "YSLib_2.8.2.0/YSLive.xcassets",
          "YSLib_2.8.2.0/expandLib/YSWhiteBoard/YSWhiteBoardResources.bundle",
          "YSLib_2.8.2.0/expandLib/YSWhiteBoard/YSWhiteBoardSkin.bundle",
          "YSLib_2.8.2.0/expandLib/YSWhiteBoard/YSWhiteBoardImage.xcassets",
          "YSLib_2.8.2.0/expandLib/BMKit/BMTZImagePickerController.bundle",
          "YSLib_2.8.2.0/expandLib/BMKit/BMKitImage.xcassets",
          "YSLib_2.8.2.0/expandLib/BMKit/BMKitResources.bundle",
          "YSLib_2.8.2.0/expandLib/BMKit/BMDatePicker.nib"

        ss.vendored_frameworks =
          "YSLib_2.8.2.0/YSSDK.framework",
          "YSLib_2.8.2.0/expandLib/YSSession.framework",
          "YSLib_2.8.2.0/expandLib/CloudHubRTC.framework",
          "YSLib_2.8.2.0/expandLib/YSWhiteBoard/YSWhiteBoard.framework",
          "YSLib_2.8.2.0/expandLib/BMKit/BMKit.framework"

        ss.dependency 'Masonry'
  
        ss.user_target_xcconfig = {
          'ENABLE_BITCODE' => 'NO',
          "GCC_PREPROCESSOR_DEFINITIONS" => "DEFYSSDK=1",
          "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "DEFYSSDK"
        }

        ss.pod_target_xcconfig = {
          'ENABLE_BITCODE' => 'NO',
          "GCC_PREPROCESSOR_DEFINITIONS" => "DEFYSSDK=1",
          "SWIFT_ACTIVE_COMPILATION_CONDITIONS" => "DEFYSSDK"
        }
  end
  
  s.dependency 'MGJRouter'

 # s.prefix_header_file = 'BaseSDK/MBasis.pch'

end
