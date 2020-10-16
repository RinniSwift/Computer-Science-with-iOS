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
