source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0' 
# iOS version may be discussed but since the updates are imposed by Apple itself,
# on the hardware side, and the last 8.* was released in August 2015, it is reasonable
# to require iOS 9.0 as the minimum version.
swift_version = "3.0"
use_frameworks!
inhibit_all_warnings!

target 'FFTest' do
  # These are all dependencies I normally use and enjoy using
  # All have an acceptable level of contribution/support
  # Pods for FFTest
  pod "Cartography", "1.0.1"  # Provides a simpler way for using AutoLayout  
  pod "Nuke", "5.1"           # Benchmarked (by its own author) as the best
  pod "PromiseKit", "4.2.0"   # Simplifies life in general
  pod "Argo", "4.1.2"         # Parsing JSON
  pod "Curry", "3.0.0"        # Introduces currying for parsing JSON with custom operators
  pod "CryptoSwift", "0.6.9"  # For securing/encripting

  target 'FFTestTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
  end

  target 'FFTestUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end
