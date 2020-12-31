*[previous page: closures](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/closures.md)*

# Error handling

1. Functions that can fail can be marked with `throws`

```swift
/// A throwing function that returns [UIImage].
func retrievePosts() throws -> [UIImage] {
    guard let path = someFilePath else {
        throw StorageError.noKnownPath // possibility to throw an error
    }
    
    let data = try Data(contentsOf: path) // possibility to throw an error

    if let images = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [UIImage] { // possibility to throw an error
        return images // possibility to return `[UIImage]` type
    }

    throw StorageError.unknownError // possibility to throw an error
}

/// A throwing function that returns void.
func storePosts(_ images: [UIImage]) throws { ... }
```

Then you can handle these errors through the do catch statement within the function below:

```swift
func loadImages() {

    // 1.

    do {
        let images = try StorageManager.shared.retrievePosts()
        // display images
    } catch StorageError.unknownError, StorageError.noKnownPath { // catching for specific errors
        // display some UI
    } catch{
        // unknown error
        // display some other UI
    }
    
    // 2.
    
    do {
        let images = try StorageManager.shared.retrievePosts()
        // display images
    } catch is StorageError { // catching for `StorageError` type
        // display some UI
    }
}
```

Others ways to not catch the error are by using the `?` and `!` operator.

```swift
func loadImages() {

    // 1. `?`

    /// images will be an optional type -- [UIImage]?
    let images = try? StorageManager.shared.retrievePosts()
    
    // 2. `!`
    
    /// `images` will be the original return type of the throwing function.
    /// This call will expect no error thrown at runtime. Swift runtime catches these errors and intentionally crashes the app.
    let images = try! StorageManager.shared.retrievePosts()
}
```

*[next page: data persistence](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/dataPersistence.md)*
