# SSFlipViewController

[![CI Status](https://img.shields.io/travis/sestinj/SSFlipViewController.svg?style=flat)](https://travis-ci.org/sestinj/SSFlipViewController)
[![Version](https://img.shields.io/cocoapods/v/SSFlipViewController.svg?style=flat)](https://cocoapods.org/pods/SSFlipViewController)
[![License](https://img.shields.io/cocoapods/l/SSFlipViewController.svg?style=flat)](https://cocoapods.org/pods/SSFlipViewController)
[![Platform](https://img.shields.io/cocoapods/p/SSFlipViewController.svg?style=flat)](https://cocoapods.org/pods/SSFlipViewController)

## What is it?

SSFlipViewController makes it easy to rotate your Swift views in 3D about any axis.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SSFlipViewController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SSFlipViewController'
```
## Usage
To use as a view within another UIViewController:
```swift
import SSFlipViewController

override func viewDidLoad() {
    let flipVC = SSFlipViewController()
    flipVC.frontVC = viewController1
    flipVC.backVC = viewController2
    addChild(flipVC)
    view.addSubview(flipVC.view)
}
```
## Author

sestinj, sestinj@gmail.com, Sam Sesti on the App Store

## License

SSFlipViewController is available under the MIT license. See the LICENSE file for more info.
