Pod::Spec.new do |s|
    s.name 				= "Redux"
    s.version 			= "0.0.1"
    s.swift_version 	= '5.0'
    s.summary         	= "Sort description of 'Redux' framework"
    s.homepage        	= "https://github.com/amine2233/Redux"
    s.license           = { type: 'MIT', file: 'LICENSE' }
    s.author            = { 'Amine Bensalah' => 'amine.bensalah@outlook.com' }
    s.ios.deployment_target = '12.0'
    s.osx.deployment_target = '10.14'
    s.tvos.deployment_target = '12.0'
    s.watchos.deployment_target = '5.0'
    s.requires_arc = true
    s.source            = { :git => "https://github.com/amine2233/Redux.git", :tag => s.version.to_s }
    s.source_files      = "Sources/**/*.swift"
    s.pod_target_xcconfig = {
        'SWIFT_VERSION' => s.swift_version
    }
    s.module_name = s.name
end