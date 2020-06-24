# NarratiiveSDK

[![CI Status](https://img.shields.io/travis/git/NarratiiveSDK.svg?style=flat)](https://travis-ci.org/git/NarratiiveSDK)
[![Version](https://img.shields.io/cocoapods/v/NarratiiveSDK.svg?style=flat)](https://cocoapods.org/pods/NarratiiveSDK)
[![License](https://img.shields.io/cocoapods/l/NarratiiveSDK.svg?style=flat)](https://cocoapods.org/pods/NarratiiveSDK)
[![Platform](https://img.shields.io/cocoapods/p/NarratiiveSDK.svg?style=flat)](https://cocoapods.org/pods/NarratiiveSDK)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Add NarratiiveSDK to Your iOS App

NarratiiveSDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NarratiiveSDK'
```

Save the Podfile and run:

```ruby
pod install
```

This creates an .xcworkspace file for your application. Use this file for all future development on your application.


## Initialize NarratiiveSDK for your iOS App

Now that you have the configuration file for your project, you're ready to begin implementing. First, configure the shared Analytics object inside AppDelegate. This makes it possible for your app to send data to Analytics. 

To do so, import the NarratiiveSDK libruary and override the `didFinishLaunchingWithOptions` method to configure NarratiiveSDK:

    guard let sdk = NarratiiveSDK.sharedInstance() else {
      assert(false, "Narratiive SDK not configured correctly")
    }

    // Optional, out put debug information when `true`
    // Remove before app release.
    sdk.debug = true
        
    sdk.setup(withHost: "YOUR_HOSTNAME", andHostKey: "YOUR_HOSTKEY")
 

Example: [AppDelegate.swift](./Example/NarratiiveSDK/AppDelegate.swift)
 

## ADD screen tracking

Here you’ll send a named screen view to NarratiiveSDK whenever the user opens or changes screens on your app. Open a View Controller that you'd like to track, or if this is a new application, open the default view controller. Your code should do the following:

    override func viewWillAppear(_ animated: Bool) {
        if let inst = NarratiiveSDK.sharedInstance() {
            inst.send(screenName: "/first-page")
        }
    }


Example: [FirstViewControler.swfit](./Example/NarratiiveSDK/FirstViewControler.swfit)

The `screenName` is used to identify the screen view. It should follows a URL path format and be in lowercases.


## Author

git, david@narratiive.com

## License

NarratiiveSDK is available under the MIT license. See the LICENSE file for more info.
