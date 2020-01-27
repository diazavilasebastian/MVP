# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
# ignore all warnings from all pods
inhibit_all_warnings!

target 'MVP' do
  use_frameworks!
  
  pod 'SDWebImage'
  pod 'Alamofire'

  target 'MVPTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble-Snapshots'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['Nimble','Quick'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
      end
    end
  end
end
