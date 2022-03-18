# StargazersKit

StargazersKit is a library for fetching the list of stargazers of a given GitHub repository if the device's security standards are met.

* [Basic Usage](#basicusage)
* [Installation](#installation)
* [License](#license)

## Basic Usage

First you need to configure the framework. To do so you need to call `StargazersApp.configure()` in the app delegate.

```swift
import StargazersKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    StargazersApp.configure()
    return true
  }
}
```

then you simply call

```swift
StargazersApp.shared.stargazers(
  for: REPO HERE, 
  owner: REPO OWNER HERE, 
) { result in 
  switch result {
    case .success(let stargazers):
      print("Here are the stargazers: ", stargazers)
      break
    case .failure(let error):
      print("ERROR: ", error)
      break
  }
}

```

## Installation

You can add StargazersKit to an Xcode project by adding it manually.

1. [Download](https://github.com/rcasula/stargazers-kit/releases) a copy of StargazersKit.

2. Drag the downloaded `StargazersKit.xcframework` in your own project and make sure is set to be embedded in the **Embedded Binaries** section of the **General** tab of your application target.

> :bulb: **Tip**: see the [Example Application] for examples of such integration.

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.

