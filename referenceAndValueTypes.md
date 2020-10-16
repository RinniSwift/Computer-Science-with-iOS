*[previous page: memory management](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/memoryManagement.md)*

# Reference and Value Types

**Reference Types**
- Great for inheritance.
- Does not support mutliple inheritance for classes.
- Great for state keeping across the app as it's passed by reference and modified changes are reflected among every instance.

**Value Types**
- Does not support inheritance. 
- Enums and structs cannot inherit from their types.
- Great for keeping a copy for modifying.


## Classes and Structs

Going to start off by noting that classes are reference types and structs are value types. This means that instances of a class, is pointed to the same point in memory, making all modifications reflects on the object. And each struct creation is unique, making all modifications not shared between instances of the same struct. Beware of unkowingly creating retian cycles. As reference count increases, make sure that holding onto object strongly wouldn't cause an issue.

Unlike structs, classes can build on each other as class inheritance to modify some provided functionality and poperties.

Classes offer more flexibility by inheritance and keeping state across the application, and structs offer more safety and are thread safe.

## Classes

A class can be thought of a parent providing initial values for state and implementations of behavior. All variables within the class that is declared as non optional or non implicitly wrapped, must be initialized the instant the class is initialized — you must provide values for all properties during initialization.

```swift
class User {
   var name: String
   var email: String
   
   weak var device: Device
}
```

This will not compile since both of the stored properties aren't provided value during initialization.

runtime error: `Stored property 'email' without initial value prevents synthesized initializers`

Inializers aren't needed since classes provide default initializers already, but when there are properties that the class can't infer the values, an initializer is necessary.

You can fix this through these ways:

```swift
// 1. Provide a default value.
var name: String = ""
// 2. Provide an optional typed property (optional types default values are nil).
var name: String?
// 3. Provide an implicitly unwrapped property.
var name: String!
```

The last one isn't as safe and you have to be sure that the class will contain that value or else it will crash from expecting a value but it being nil. — on the other hand, you wouldn't have to deal with it being a nil value and not needing to provide a value during initialization.

**Class inheritance**

You can inherit from classes, and build on top of it's existing functionality by using the `override` on functions of the super class. You can also provide other properties and create your own intializer but it must call your super classes initializer — calling `super.init(...)` in your newly created initializer.

## Structs

Structs offer a memberwise initializer by default. As earlier mentioned, structs are value types, meaning that every modification is unique to the variable that it's stored. Keep in mind when creating functions that are going to modify the stored properties, you must prepend the function with `mutating`.

```swift
struct Person {
   var name: String
   var lastName: String
   
   mutating func changeLastName(to lastName: String) -> Bool {
      self.lastName = lastName
   }
}
```

*[next page: gcd](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/gcd.md)*
