*[previous page: data handling within app](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/dataHandling.md)*

# A collection of Swift used keywords

- `@objc`
- `escaping`
- `available`
- `final`

- `instance properties` and `type properties`
- `class` and `static`
- `lazy` stored properties


## Declarations
Declarations introduce new names or constructs into your program. You use *declarations* to introduce; classes, functions, methods, variables, constants, enums, structs, and protocols.

- **Import declaration** let's you use modules, symbols that are outside of the file scope.\
`import MODULE` this will import the entire module\
`import MODULE.SUBMODULE`, `import MODULE.SYMBOLNAME` this will import only the specified symbol or submodule. Which gives you more details limits since this does not import the entire module.

- **Constant declaration** this defines an immutable binding between the constant name and the value. After a value of a constant is set, it cannot be changed. If a constant is initialized with a class object, the object can change but the binding between the constant name and the object cannot. When a constant is declared inside a class or struct, it is considered a *constant property*; unlike *computed properties* where they have getters and setters. *Constant properties* are properties that can be used by all instances, like static constants, static variables, and variable properties.

> When a constant is declared at global scope, it must be intialized with a value. It has to have a value set before it's value gets read.

- **Variable declaration** this defines mutable values. 

> Declaring variables in the global scope or local scope of a function is referred to as a *stored variable*. Declaring variables in the context of a class or struct is referred to as a *stored variable property*.\
> Variables can also be declared as *computed variables* or *computed properties*. Declaring variables in the global scope or local scope of a function is referred to as a *computed variable*. Declaring variables in the context of a class or struct is referred to as a *computed property*

**Stored variable declaration**
```swift
var NAME: TYPE = EXPRESSION
```

**Computed variable declaration**
```swift
var NAME: TYPE {
   get {
     STATEMENTS
   }
   set(SETTERNAME) {
     STATEMENTS
   }
}
```

> The **Getter and Setter**. The *getter* is used to read the value, the *setter* is used to write the value. The setter is optional and when you only want to have a getter, you can omit both clauses and simply return the value. This is called a *read-only computed property* as seen below. But if there's a setter, there must also be a getter.\
> the SETTERNAME is optional. This can be left blank and the new value to use in the following clause is accessed as `newValue`. And in the get clause is simply omitting the `return`.

> You can also declare a stored variable or stored property with `willSet` and `didSet` observers. When you define variables with property observers in a global scope or a in a local function, they are referrred as *stored variable observers*. Declaring them in the context of a class or struct they are referred as *property observers*.

**Stored variable observer declaration**
```swift
var NAME: TYPE = EXPRESSION {
   willSet(SETTERNAME) {
     STATMENTS
   }
   didSet(SETTERNAME) {
     STATEMENTS
   }
}
```

> These observers provide a way to observe and respond appropriately when the value of a property is being set. The observer is not called when the variable or property is first initialized. -- It's called outside of the initialization context.\
> the `willSet` gets called right before the variable or property is set. And a value is passed as a constant to the willSet clause.\
> the `didSet` gets called right when the new value is set. The old variable or property is passed to the didSet clause.\
> the SETTERNAME in both parameters are optional. The new value in the `willSet` is accessed as `newValue` and the old value in the `didSet` is acccessed as `oldValue`. And you can use either didSet or willSet. They don't have to be called at the same time.

```swift
var NAME: TYPE {   // read-only computed property
   return EXPRESSION
}
```

**Stored type properties and computed type properties**
You define type properties with the `static` keyword. For computed type properties in a class, you can use the `class` keyword. [to allow subclasses to override the superclass's implementation]

```swift
class NAME {
   static var NAME = EXPRESSION
   static var NAME: TYPE {
     return STATEMENT
   }
   class var NAME: TYPE {
     return STATEMENT
   }
}
```
Classes can have both `static` and `class` keyword. The `class` is used in a class type and makes the property overrideable.

- **Type alias declaration** this introduces a named alias of an existing type into the program

```swift
typealias NAME = EXISTINGTYPE
```
After it has been declared, it can be used instead of the existing type everywhere in the program.\
An example of how this could be useful is using generic parameters to give names to an existing parameter.

```swift
typealias StringDictionary<Value> = Dictionary<String, Value>
typealias DictionaryOfInts<Key: Hashable> = Dictionary<Key, Int>
```

- **Function declaration** this introduces a function or method into your program. A function declared in the context of a class, struct, enum, or protocol is referred to as a method.

```swift
func NAME(PARAMS) -> RETURNTYPE {
   STATEMENTS
}

func NAME(PARAMS) {  // for return type of Void
   STATEMENTS
}
```
The type of each parameter must be included. The parameter name can be suppressed when calling the function if you use an *underscore*(_). Or to modify functions from an outside scope, you must use an *in-Out parameter*. \
This is how in-Out parameters work in a function:\
    - when the function is called, the value is copied\
    - in the body of the function the copy is modified\
    - it copies the modified value and assigns it back to the original argument\
Also known as *copy-in copy-out* or *call by value result*. But as an optimization, if the argument is stored at an address in memory, the same memory is used both inside and outside the function body. -- no need for copying. This is called the *call by reference* behaviour.\
A parameter with an *equal sign* and an expression after its type is providing a default value. If the parameter is omitted when calling the function, the default value is used instead.\
Keep in mind that the caller will only see a single change as the new value is copied back. Even if the function does not mitate it's inout parameter.

**Throwing functions and methods** which are for methods that can throw an error.

```swift
func NAME(PARAMS) throws -> RETURNTYPE {
   STATEMENTS
}
```

- **Enumeration declaration**. Declared enums can contain zero or more values called enumeration cases. and any other declarations including computed properties, instance methods, type methods, type aliases, and even other enumeration, strucuture, and class declarations. Enums can also contain associated types. Use the switch statement to switch between cases, and the dot (.) syntax to reference a case. And 

- **Structure declaration**. Declared structures contain zero or more declarations. And declarations including stored, computed properties, type properties, instance methods, type methods, subscripts, typealiases, and other structs, classes, enums.

- **Class declaration**
- **Protocol declaration**. These are declared at global scopes and contains zero or more protocol member declarations which describe the conformance requirements that any type adapting the protocol must fulfill. By conforming to the protocol, it must implement all of the adapted protocol's requirements.
- **Initializer declaration**. These introduce initializations for a class, struct, or enum. Unlike structs and enums, classes have two kinds of initiailizers: *designated intiailizers* and *convenience initializers*. check out more on initialization in my [initialization file](https://github.com/RinniSwift/iOS/blob/master/Initializers.md)



## Statements

## Expressions


## Stored Type Properties and Computed Properties
> Computed properties have getters and/or setters and must always be set as a variable property
> Stored type properties can be set as a variable or constant and must always be intialized a default value.
> Stored type protperties are lazily initialized on their first access and do not need to be marked with the lazy modifier.

## Instance Properties and Type Properties
*Instance properties* are properties that belong to an instance of a type. This provides distinction between each instance of the type. But, you can also define properties that belong to the type itself, not to any one instance of that type. And there will only be 1 copy of these properties no matter how many instances. These are called *type properties*
