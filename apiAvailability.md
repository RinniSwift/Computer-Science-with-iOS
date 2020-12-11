*[previous page: optionals](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/optionals.md)*

# API Availability

When calling API's in your project, Swift will check if the usage is available in the minimum iOS deployment target (Can be found in your project info folder), if it's not, you'll receive an error. In that case, you can just bump your minimum supporting version to the latest / the version the API supports, or, add checks since you probably don't want to be limiting yourself from using the new API.

You can execute this code below

```swift
if #available(iOS 13, *) {
    // is executed if platform is running iOS 13 or above, from the * sign.
    // use API
} else {
    // use another API
}
```

**If you're writing more low level code and want to specify your API to be called from a certain iOS**, you mark the function or class with `@available`

```swift
@available(iOS 13, *)
func iOS13Supported() {
    // ...
}
```

*[next page: data handling within app](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/dataHandling.md)*
