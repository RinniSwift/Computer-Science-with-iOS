# Computer-Science-with-iOS


# iOS Knowledge
*A collection of iOS knowledge bellow.*

# Memory Management

Memory management is specifically about allocating and recycling of specific data. recycling can also mean deallocating which creates another availability for reassignment. In iOS, it's done automatically by **ARC**, ***A**utomatic **R**eference **C**ounting*, and not manually by programmers/developers. To do it manually, you might have to know how to use the following functions:

```swift
HeapObject() // struct that contains the the reference counts and type metadata
swift_retain() // initializing
swift_release() // destruction of `HeapObject`s
```

ARC manages freeing objects only if the reference count of the object becomes 0. 

Reference count only increments when the object is declared as strong or is held strongly by another object. — objects are declared strong by default. To hold onto the object weakly, you can predefine it with the `weak` or `unowned` keyword.

**Strong referenced objects**
Increment the reference count by one.
Expects the value to not be nil at use time.

**Weak referenced objects**
Does not increment the reference the count by one.
Is an optional type — the value can become nil at any given moment of the application.

**Unowned referenced objects**
Does not increment the reference the count by one.
Is a non optional type — the value expected can not become nil at the on call. — It must have the same lifetime or a longer lifetime.

When a reference objects count becomes 0 at any given moment, it gets dealloced or freed. — You get notified through the deinit() function on the UIViewController. 

When creating an application, you create reference types and value types. Reference types being classes, functions, and closures. value types being constants, variables, enums, and structs. This data gets stored in the heap and the stack. The Heap storing reference types — long lived data and object, and the stack storing value types. 

### **Heaps**

Each applications uses the same heap as the devices. So there's no fixed amount of data the app can consume, other than the heap growing in memory near it's limit. Each heap contains 1 stack.

### Stack

there's also the term of function call stack where each functions data is stored onto the stack and is accessed in LIFO order, so if there were nested functions, the function that is most nested will have to return first before executing the top most function

### Memory Segments

There're 4 memory segments in memory management.

1. **Text Segment** *contains the machine instructions produced by the compiler to translate swift code into machine code. This method is read only.*
2. **Data Segment** *contains all the global data that needs an initial value when the program starts. → static variables, constants, type metadata.*

    *contains **BSS data** — (Block Started by Symbol / Better Save Space [as they like to say]) uninitialized data. data that does not require an initial value — static variables.*

3. **Heap** *store dynamically allocated objects, reference types — objects that have a lifetime*
4. **Stack** *store method parameters and local variables, Value types.*

## Retain cycles

retain cycles happen when two references hold onto each other strongly. Thus creating a loop that will never let the other become nil / decrement the reference count. 

Not only can retain cycles happen within class referencing but they can also happen within closures.

## Concurrent program issues

### Deadlock

Happens when two threads are waiting for each other to release a shared resource, ending up blocked for infinity.

### Race conditions

Happens when two or more threads access a shared data source and change it's value at the same time.

### Readers writers problem

### Thread explosion

### Priority inversion

Happens when low priority tasks lock a resource needed by a higher priority task.

> :pushpin: **SUMMARY**
>
> Memory management is tightly connected with the concept of Ownership. ARC is Swift ownership system. ARC is implemented on the compiler level. The swiftc compiler calls methods wherever appropriate.

> ❓**Questions**
> - Where does data that is initialized as zero stored?
>   This is uninitialized data and it is stored in the BSS area, in the data segment.
> - How many levels does Swift have for reference types?
> - What is the difference between week and unowned?

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
