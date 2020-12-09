*[previous page: testing](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/testing.md)*

# SwiftUI

Apple's new UI framework.


In SwiftUI, views are values (structs) instead of objects. Which creates a new layout system. 

## View Construction

The view hierarchy is represented as trees just like in UIKit.\
Simply put, you create a tree of view values to represent what should be on screen. When you modify state (modify the @State property), a new tree of view values is computed.\
To debug into the view's hierarchy, the [Mirror API](https://developer.apple.com/documentation/swift/mirror) comes in handy especially that `some view` is an [opaque type](https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html) -- hiding type information apposed to concrete types.

```swift
print(Mirror(reflecting: self).subjectType)
print(Mirror(reflecting: self).children)
```

> Fun fact: The trailing closure after views is not a normal function, it's a [ViewBuilder](https://developer.apple.com/documentation/swiftui/viewbuilder).

## Compared to UIKit

UIKit is much more prone for views not syncing with models but with SwiftUI, state modifications will always update the UI to reflect whatever that may change. -- View construction and view updates are two different code paths in UIKit. In the SwiftUI, these two code paths are unified: there is no extra code we have to write in order to update the text label onscreen. Whenever the state changes, the view tree gets reconstructed, and SwiftUI takes over the responsibility of making sure that the screen reflects the description in the view tree.

## View layout

APIs like `.frame` and `.offset` don't modify the view driectly, but rather wraps the view in a modifier. So when calling `.frame(width:height:)` on a view, the view won't change it's frame, but it will be placed inside another frame -- wrapped in a modifier. Therefore, the order of calling the view modifiers are very important.


*[next page: optionals](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/optionals.md)*
