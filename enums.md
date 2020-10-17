*[previous page: ui](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/ui.md)*

# Enums

enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.
There're C enumerations but they're defined by integer values.
Enums in Swift are much more flexible, and don’t have to provide a value for each case of the enumeration. If a value (known as a raw value) is provided for each enumeration case, the value can be a string, a character, or a value of any integer or floating-point type.

### Switch statements

enums support switch statements for matching enumeration values.

```swift
enum Filter {
    case openNow
    case discounted
}
```

```swift
let selectedFilter = Filter.openNow
switch selectedFilter {
case .openNow:
    print("open now")
case .discounted:
    print("discounted")
}
```

You must provide a case in the switch statement to not ommit any enum cases. This is because switch statements on enums must be exhaustive.

```swift
switch selectedFilter {
case .openNow:
    print("open now")
default:
    print("other case/s")
}
```

**Switch Statement**

`default` covers cases that aren't addressed explicitly.

switch statements compares one or more values in the same line: `case .openNow, .discounted`

switch statements in swift are not fallthrough by default unlike objective-c where you'd need an explicit `break` statement to not fallthrough to the next case. To make switch cases fallthrough, use the `fallthrough` statement.

### Iterating enum cases

In order to make the cases within the enum iterable, you must conform the enum to `CaseIterable`. This gives the enum an additive property of `allCases` which returns an array of the cases in sorted order from the enum definition.

```swift
enum Filter: CaseIterable {
    case openNow
    case discounted
}
```

Calling `Filter.allCases` will return 

```swift
[Fiter.openNow, Filter.ascendingPrice, Filter.descendingPrice, Filter.discounted]
```

Now if you were to have associated values for a case in your enum, you would have to define the `allCases` property yourself.

```swift
enum Filter: CaseIterable {
    case openNow
    case discounted
    case distance(miles: UInt)

    static var allCases: [Filter] {
        return [.openNow, .discounted, .distance(miles: 7)]
    }
}
```

Because enums can't know the value of the associated type, it can't infer the all cases. You must define it yourself.

*[next page: closures](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/closures.md)*
