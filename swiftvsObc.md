*[previous page: foundation](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/foundation.md)*

# Swift VS. Objective-C

Some comparisons or features that Swift or Objective-C has that are really cool!

## Enums

[Objc enums](https://objective-c.programmingpedia.net/en/tutorial/1461/enums) are more limited than Swift's. Doesn't allow functions within enums. Raw Representable type is only supported by Int -- doesn't support String representable.

[Swift enums](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) are quite extensive. Allows different raw representable. Values can contain associated types. An example is `Result` type -- introduced in Swift 5, is an enum containing two important values: `error` and `success`. Both with associated types. `error: Error`, `success: <T>`.

> **Interestingly**: When bridging Swift enums to Objc, the swift enum must be Int type raw representable. So I tried storing the enum values into an array in Objc, but interestingly enough, `Int` is a value type. Whereas `NSMutableArray` can only store object types! So interesting! So in order to store the enum value types into an objc array, I had to convert the `Int` into an `NSNumber`.

This leads into another great feature that Swift provides but not Objective C, [Generics](https://docs.swift.org/swift-book/LanguageGuide/Generics.html).

## Generics

Generics can make code extremely clean by abstracting exact data types but gives space to defines some behaviors of that type.

An example I gave above about `Result` types, is applicable here too! as both cases, `error` and `success`, are built with generics.\
I created a Medium article about [Building a clean and modularized networking layer using generics and Result types](https://medium.com/@rinradaswift/networking-layer-in-swift-5-111b02db1639). Give it a checkout. Definetely has some cool tips and tricks!

This is the Result type's declaration:
```swift
@frozen enum Result<Success, Failure> where Failure : Error
```
`Success` can be of any type.\
`Failure` can be of any type that conforms to `Error`.

Putting Result types aside, You'd generally use generics to achieve flexible and reusable functionality that can be applied to many different types across Swift. They're extremely clean!

Examples of APIs that are built on top of generics:
- `func swap<T>(_ a: inout T, _ b: inout T)`
- `swapTwoValues(_:_:)`
- `Result` type

The `T` you'd see around generics refers to the placeholder of it's **T**ypes parameter. You'll usually define `T` right after a function or class call, enclosed by `<>` -- `<T>`.


## Switch Statements

Objc supports limited switch statements. Does not support switch statements on String, but do support number switches, character, and error.\
Switch statements also fallthrough to the next case. So must keep in mind of `break`.

Swift supports switch statments on almost anything, String, Int.\
Switch statements are not `fallthrough`. So keep in mind of `fallthrough` keyword to customize it there.\
With Swift containing a string raw representable, it can come in handy when decoing JSON values! You can decode the enum into a `String` type and continue on to initialize the enum with it's string type, by falling back to a default enum case that's appropriate.

*[back to menu](https://github.com/RinniSwift/Computer-Science-with-iOS#computer-science-with-ios)*
