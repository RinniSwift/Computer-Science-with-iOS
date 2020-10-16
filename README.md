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

# GCD

Grand Central Dispatch manages the execution of tasks on the apps main thread or background thread. They are ***task-based paradigm*** which allows to write concurrent code without thinking about threads.

### Queues

You enqueue ***DispatchWorkItem***s to a ***DispatchQueue*** or a ***DispatchGroup*** for execution and dequeuing is handled automatically. They can be categorized by QoS which determines the order/ priority of execution. Order of execution is FIFO. **Concurrent queues** are not guaranteed that tasks will finish in order since they are executed by not having to wait for other tasks to complete. While **serial queues** execute in order of added items with having to wait for tasks to finish before executing the next. There are initially 5 queues ready to use, 1 serial queue — main queue, and 4 concurrent queues having different priorities — **high**, **default**, **low**, **background**.

```swift
// intializing a queue
let queue1 = DispatchQueue.global()
let queue2 = DispatchQueue(label: "serialQueue")

// executing tasks
queue1.sync { ... }
queue1.sync(execute: DispatchWorkItem)
queue1.async { ... }
queue1.async(execute: DispatchWorkItem)
```

### QoS

Categorizes tasks to be performed on DispatchQueues. Higher priority work requires more energy so choose accordingly to the use case as it directly impacts apps responsiveness and app energy.

* **user Interactive**
   user-interactive tasks, such as animations, event handling, or updating your app's user interface.

* **user Initiated**
   tasks that prevent the user from actively using your app.

* **default**
   default

* **utility**
   tasks that the user does not track actively.

* **background**
   for maintenance or cleanup tasks that you create.

* **unspecified**
   literally nothing.

### Threads

GCD has a thread pool that services all queues. Threads can be created when all other threads are busy. 

A thread is a series of instructions that can be executed by a run time.

Thread memory and creation:

- Each thread consumes 1KB of memory in kernel space.
- The main thread stack size is 1MB and cannot be changed.
- Any secondary thread is allocated 512KB of stack space by default.
- The minimum allowed stack size is 16KB

There can be multiple threads in your project, but there’s a limit to when you use them on your device. Modern iPhones have 4 cores, meaning it can run 4 threads. But with intel, it tricks the cpu into thinking there’s 2 threads in one thread. So really the phone will have 8 threads. Marked by the intel 8 The maximum number of thread pool size is 64.

Intel Core i7 processor takes advantage of hyper threading. a technology that kicks in when the processor is handling several big jobs at the same time. it lets/tricks each of the processors cores run two threads simultaneously, which means it can do two things at once. 

### DispatchWorkItem

Sometimes we need extra control over the execution. This is where DispatchWorkItems come in handy. You can cancel them.

```swift
private var pendingWorkItem: DispatchWorkItem?
let queue = DispatchQueue(label: "serialQueue")

func updateSomething() {
   pendingWorkItem?.cancel()

   let newWorkItem = DispatchWorkItem { ... }
   pendingWorkItem = newWorkItem

   queue.async(execute: newWorkItem)
}
```

### DispatchGroup

Sometimes we need to execute all heavy tasks before being able to continue. This is where DispatchGroups come in handy. You can call the `wait` or `notify` method to know that all tasks have complete in the group

This is how you do a **blocking waiting**

```swift
let queue = DispatchQueue(label: "serialQueue")
let group = DispatchGroup()

queue.async(group: group) {
   sleep(1)
   print("Task 1 done")
}

queue.async(group: group) {
   sleep(2)
   print("Task 2 done")
}

group.wait()

print("All tasks done")

// Task 1 done
// Task 2 done
// All tasks done
```

This is how you do a **non blocking waiting**. Notice the balancing of the `enter` and `leave` calls.

```swift
let queue = DispatchQueue(label: "serialQueue")
let group = DispatchGroup()

group.enter()
queue.async {
   sleep(1)
   print("Task 1 done")
   group.leave()
}

group.enter()
queue.async {
   sleep(2)
   print("Task 2 done")
   group.leave()
}

group.notify(queue: queue) {
    print("All tasks done")
}

print("Continue execution immediately")

// Continue execution immediately
// Task 1 done
// Task 2 done
// All tasks done
```

> :bulb: There are cases where you would want to use DispatchGroups even if they were on the main queue. Such as tasks that are handled in the background queue elsewhere, or tasks that take a lot of time. And you wouldn't need to specify the queue. When you call the notify call, you would just specify with the main queue — 
group.notify(queue: .main) { ... }
>
> When the line above is run, without any tasks added to the queue, it will still fall through in the notify block when the compiler runs to it.

### DispatchSemaphore

Sometimes you want to limit work in progress when you know there are a lot of tasks you want to execute during the same time without trying to thread explode — which is when the pool hits the limit of 65 threads.

Below, we are limiting the amount of concurrent tasks it can execute at a time.

```swift
let concurrentTasks = 3

let queue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
let semaphore = DispatchSemaphore(value: concurrentTasks)

for _ in 0..<999 {
   queue.asnyc {
      // Do some work
      sema.signal()
   }
   sema.wait()
}
```

There're also parallel executing for efficient for loop. It must be called on a specific queue not to accidentally block the main one:

```swift
DispatchQueue.global().async {
   DispatchQueue.concurrentPerform(iterations: 999) {
      // Do some work
   }
}
```

### ❗ Can you find the flaw?

```swift
let queue = DispatchQueue(label: "Concurrent queue", attributes: .concurrent)

for _ in 0..<999 {
   // 1
   queue.async {
      sleep(1000)
   }
}

// 2
DispatchQueue.main.sync {
   queue.sync {
      print("Done")
   }
}
```

1. A new thread is being brought up in the pool to service each async operation. The pool hits the limit of 65 threads.
2. From the main queue, we call a `sync` operation on the same queue. The main thread is blocked because no available threads. At the same time, all the threads in the pool are waiting for the main thread. Since they are both waiting for each other, deadlock occurs.

> :pushpin: **SUMMARY**: every app has a main thread.

> :question: **Questions**<br />
> How many types of queues are there?<br />
>     *There are two types. Serial queues and concurrent queues. Serial queues execute tasks after the one before it has completed. Concurrent queues don't wait for one to finish to execute.*<br />
> How many queues are pre-created in GCD?<br />
> *There are initially 5 queues ready to use, 1 serial queue — main queue, and 4 concurrent queues having different priorities — high, default, low, background.*<br />
> Is the main queue a serial or concurrent queue?<br />
> *It's a serial queue. This is where all UI related tasks are executed.*<br />
> What is a thread explosion, and how can you limit this?
> *Thread explosion is when the pool exceeds the limit of 65 threads. This can be handled and limited by using a semaphore by giving the value to the semaphore to limit it down.*
