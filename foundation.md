*[previous page: collection protocols](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/collectionProtocols.md)*

# Foundation
The framework


### NSKeyedArchiver and NSKeyedUnarchiver

Deals with coding against objects that support NSCoding.\
To be able to have custom objects NSCoding compliant, include decoder and encoder functions.

`NSKeyedArchiver` is an encoder that stores an object's data to an archive referenced by keys.\
`NSKeyedUnarchiver` is a decoder that restores data from an archive referenced by keys.

```swift
func writeImages(_ images: [UIImage]) throws {
    guard let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
        // replace with some error
        throw StorageError.incorrectPath
    }

    let path = documentURL.appendingPathComponent("someKey")
    let imagesData = try NSKeyedArchiver.archivedData(withRootObject: images, requiringSecureCoding: false)
    try imagesData.write(to: path)
}

func readImages() throws -> [UIImage] {
    guard let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
        throw StorageError.incorrectPath
    }

    let path = documentURL.appendingPathComponent("someKey")
    let data = try Data(contentsOf: path)

    if let images = NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [UIImage] {
        return images
    }
}
```



> Here is a [sample project](https://github.com/RinniSwift/SwiftUISample) that I use `NSKeyedArchiver` and `NSKeyedUnarchiver` to write data to the file system through `FileManager`. Check [this file](https://github.com/RinniSwift/SwiftUISample/commit/a5dee3d62ebb182f2d321064dccd7caaf83c3cae) specifically.


### URLComponents

[URLComponents](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/urlComponents.md)
