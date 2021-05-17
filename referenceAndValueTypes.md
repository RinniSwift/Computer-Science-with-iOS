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


## Classes and Structs Differences

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

:point_up: :warning: This will not compile since both of the stored properties aren't provided value during initialization.

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


## Functions

With Swift 5.2, we're able to call a type as a function. Just simply add a method within the type called `callAsFunction()` like below:

```swift
struct Dice {
    var highValue: Int
    var lowValue: Int
    
    func callAsFunction() -> Int {
        Int.random(in: lowValue...highValue)
    }
}

let d6 = Dice(highValue: 6, lowValue: 1)
let roll = d6()
```
*code snippet from: Mastering Swift 5.3 0 Sixth Addition by Jon Hoffman*

This enables us to simplify how we call functions.


## Initializers

*Initailization is the process of preparing an instance of a class, struct, or enum for use. This process involves setting initial values for each stored property on that instance and any other setup or initialization before the instance is ready for use.*\

Different ways to implement initializers are: 
1. *Customizing initialization*
2. *Initializer parameters without argument labels*
3. *Default initializers*
4. *Memberwise initialization*

```Swift
// 1. The swift compile will decide which to call based on the argument label
struct Human1 {
    var gender: Gender
    var age: Int = 10

    init(age: Int) {
        self.age = age
    }

    init(gender: Gender) {
        self.gender = gender
    }

    init(gender: Gender, age: Int) {    // this will be called when instantiating human1
        self.gender = gender
        self.age = age
    }
}
let human1 = Human1(gender: .female, age: 19)

// 2. nameless initializers
struct Human2 {
    var gender: Gender
    var age: Int

    init(_ gender: Gender, _ age: Int) {
        self.gender = gender
        self.age = age
    }
}
let human2 = Human2(.female, 19)

// 3. default initializer
struct Human3 {
    var gender: Gender = .female
    var age: Int = 19
}
let human3 = Human3()

// 4. memeberwise initialization
struct Human3 {
    var gender: Gender
    var age: Int
}
// There is no need to create an initializer as structs already provide initializers upon call.
```

All of a classes properties--including that of any in the super class it inherits from--must be set during initialization. What if we want it to be optional where you can assign a value or not in the parameters? This is where *convenience initializers* come in handy.\
**Convenience initializers** are supporting an initializer for a class.You can design convenience inits to call a *designated initializer* by calling self.init. A convenience init must call another init within the same class, must ultimately call another designated initializer.\
**Designated Initializers** are primary initializers which fully initializes all properties in the class.
```swift
struct Human {
    var name: String

    init(name: String) {    // designated init
        self.name = name
    }

    convenience init() {    // convenience init
        self.init(name: "not set")
    }
}

let desHuman = Human(name: "Rinni")    // calls designated init. name = "Rinni"
let conHuman = Human()             // calls convenience init. name = "not set"
```
Above you can see that we designed the convenience init to call the designated init.

**Initializer Inheritance**\
how to use initializers with subclasses
```swift
class Human {
    var age: Int

    init(age: Int) {
        self.age = age
    }

    convenience init() {
        self.init(age: 0)
    }
}

class Man: Human {
    var name: String

    override init(age: Int) {
        super.init(age: age)
    }

    init(name: String, age: Int) {
        super.init(age: age)
        self.name = name
        self.age = age
    }
}
```

*[next page: gcd](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/gcd.md)*
