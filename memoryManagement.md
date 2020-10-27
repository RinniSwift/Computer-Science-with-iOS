# Memory Management

Memory management is specifically about allocating and recycling of specific data. recycling can also mean deallocating which creates another availability for reassignment. In iOS, it's done automatically by **ARC**, ***A**utomatic **R**eference **C**ounting*, and not manually by programmers/developers. To do it manually, you might have to know how to use the following functions:

```swift
HeapObject() // struct that contains the the reference counts and type metadata
swift_retain() // initializing
swift_release() // destruction of `HeapObject`s
```

### ARC
Automatic Reference Counting helps with storing references into memory and helps with cleaning up when it's not being used.\
Reference counting only applies on instances of a class.\
Each time you create a class instance, ARC automatically creates some memory to store the information. but with the deinit() method, ARC will free the memory space of that instance. ARC relates to variables with references of *strong*, *weak*, or *unknowned*\
**Strong**: all variables are strong by default and can be changed by declaring weak or unknowned\
**Weak**: [weak references between objects with indipendant lifetime] with the property of weak, it will not increment the reference count. These references are always declared as optionals because the variable can be set to nil. With ARC, it automatically sets the weak reference to nil once the instance is deallocated.\
**Unknowned**: [unknowned references between objects of the same lifetime] these references similar to weak references but must always hold a value. When the objects will be reached at the same time and dealloced at the same time.

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

### Stack and Heap differences
In multi-threaded situations, each thread has their own stack, but heap is application specific.

### Memory Segments

There're 4 memory segments in memory management.

1. **Text Segment** *contains the machine instructions produced by the compiler to translate swift code into machine code. This method is read only.*
2. **Data Segment** *contains all the global data that needs an initial value when the program starts. → static variables, constants, type metadata.*

    *contains **BSS data** — (Block Started by Symbol / Better Save Space [as they like to say]) uninitialized data. data that does not require an initial value — static variables.*

3. **Heap** *store dynamically allocated objects, reference types — objects that have a lifetime*
4. **Stack** *store method parameters and local variables, Value types.*

## Memory Leaks
A memory leak is a portion of memory that is occupied forever and never used again. or. Memory that was alloced at some point but was never released and is no longer referenced by the app. The main reason for memory leaks are caused by retain cycles.

## Retain cycles
When an object has a strong reference to another object, it is retaining it. objects in this case are reference types (classes) It is not possible to create retain cycles on value types. When an object references a second one, it owns it. the second object willl stay alive until you declare it nil.\
When object A retains object B and object B retains object A, there is a retain cycle. When two objects hold strong reference to each other, they cannot be dealloced. Retain cycles are broken when one of the references in the cycle is declared *weak* or *unknowned*. 
> Weak or unknowned references allow one instance in a reference cycle to refer to the other reference without keeping a strong hold on it.
When to use weak or unknowned: define a capture in a closure as unknowned when the closure and the instance it captures will always refer to each other and always be deallocated at the same time. Define a closure to be weak when the captured reference may become nil at any point in time.

## Concurrent program issues

### Deadlock

Happens when two threads are waiting for each other to release a shared resource, ending up blocked for infinity.

### Race conditions

Happens when two or more threads access a shared data source and change it's value at the same time.

### Readers writers problem

### Thread explosion

### Priority inversion

Happens when low priority tasks lock a resource needed by a higher priority task.

###### what's dangerous about leaks?
- Increased memory footprint of the app.\
Direct consequence of objects not being released. As the actions that create those objects are repeated, the occupied memory will grow. Leads to mempory warning and then crashes.
- Introduces unwanted side effects.\
Imagine an object that starts listening to a notification when it is created in the *init*, to stop the listening of the notification, it has to be balanced by using the *deinit*. But, if the object leaks, it will never die and it will never stop listening to the notification.
- Crashes\
Multiple leaked objects altering the database, UI, entire state of the app, causes crashes\

### Debugging Memory leaks
- using the debug navigator tool in Xcode. This tool is for checking what contains in memory. Memory leaks will be indicated with exclamation marks on the right of the object.
- knowing what object owns the closure or other object:\
e.g.1 dealing with custom cells in UITableView: When you create an action closure in the custom cell which will be called when the button is tapped: The cycle goes like this; the action closre belongs to the cell but the cell belongs on the tableView which the tableView belongs to the tableViewController\
e.g.2 dealing with grand central dispatch. The view controller doesnt have any reference to it since the dispatchQueue is a singleton so worst case the singleton keeps a reference to the closure. In most cases when closures are executed, it will drop its reference to self since self doesnt have a reference to the closure, there will be no cycle. If there is a cycle, use *unknowned* if the closure cannot exist longer than the object it captures.

#### What happens when you exaust the memory? 
- The task will stop performing. 
- task will not progress but will continue running until it hits the limit and program crashes

> :pushpin: **SUMMARY**
>
> Memory management is tightly connected with the concept of Ownership. ARC is Swift ownership system. ARC is implemented on the compiler level. The swiftc compiler calls methods wherever appropriate.

> ❓**Questions**
> - Where does data that is initialized as zero stored?
>   This is uninitialized data and it is stored in the BSS area, in the data segment.
> - How many levels does Swift have for reference types?
> - What is the difference between week and unowned?

*[next page: reference and value types](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/referenceAndValueTypes.md)*
