*[previous page: testing](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/testing.md)*

# SwiftUI

Apple's new UI framework.


In SwiftUI, views are values (structs) instead of objects. Which creates a new layout system. 

## View Construction

The view hierarchy is represented as trees just like in UIKit.\
You create a tree of view values to represent what should be on screen. When you modify state (@State, @ObservedObject, @StateObject, ...), SwiftUI efficiently reevaluates it's views.

> SwiftUI only reexecutes the body of a view that uses a @State property (and some other property wrappers -- @ObservedObject, @Environment).\

**View udpates**\
When these following properties @State, @ObservedObject, @StateObject change, it triggers the view's properties to change. (text, coloring).\
And this is the only way to update UI. As apposed to some ways we'd update in UIKit through a completion block.\ 
This helps with resolving UI getting out of sync with our data.\
In comparison, SwiftUI uses a single code path that constructs both the initial view and updates to views. Whereas UIKit uses two code paths; one for initial view construction and another for view updating.

To debug into the view's hierarchy, the [Mirror API](https://developer.apple.com/documentation/swift/mirror) comes in handy especially that `some view` is an [opaque type](https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html) -- hiding type information apposed to concrete types.

```swift
print(Mirror(reflecting: self).subjectType)
print(Mirror(reflecting: self).children)
```

> Fun fact: The trailing closure after views is not a normal function, it's a [ViewBuilder](https://developer.apple.com/documentation/swiftui/viewbuilder).

## Compared to UIKit

UIKit is much more prone for views not syncing with models but with SwiftUI, state modifications will always update the UI to reflect whatever that may change. -- View construction and view updates are two different code paths in UIKit. In the SwiftUI, these two code paths are unified: there is no extra code we have to write in order to update the text label onscreen. Whenever the state changes, the view tree gets reconstructed, and SwiftUI takes over the responsibility of making sure that the screen reflects the description in the view tree.

## View layout

View APIs such as `.frame` and `.offset` don't modify the view directly, but rather wraps the view in a modifier. So the ordering of the call is very important.\
When calling `.frame(width:height:)` on a view, the view won't change it's frame, but it will be placed inside another frame -- wrapped in a modifier. 


*[next page: optionals](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/optionals.md)*
