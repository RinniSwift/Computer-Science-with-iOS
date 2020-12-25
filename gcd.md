*[previous page: reference and value types](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/referenceAndValueTypes.md)*

# GCD

Grand Central Dispatch manages the execution of tasks on the apps main thread or background thread. They are ***task-based paradigm*** which allows to write concurrent code without thinking about threads.\
Moves the thread management code down to the system level. All you have to do is define tasks you want to execute and put them in the appropriate dispatch queue. GCD takes care of creating the needed threads and scheduling tasks to run on those threads.\
GCD organizes tasks into specific queues, and later on the tasks on the queues will get executed in a proper and available thread from the pool. The dispatch framework is a very fast and efficient concurrency framework

### Synchronous and Asynchronous execution
Each work item can be executed either synchronously(serially) or asynchronously(concurrently). 
with synchronous tasks, you'll block the execution queue, but with async tasks, your call will instantly return and the queue can automatically continue the execution of remaing tasks.

###### Synchronous
synchronous work items are called with the sync method. The program waits until the execution finishes before method call returns to continue the remaing tasks. functions with return types are most likely to be synchronous

###### Asynchronous
asynchronous work items are called with the async method. The method returns immediately. completion blocks are most likely to be asynchronous.
With dispatch queues, you can execute your code synchronously or asynchronously. with synchronous execution, the queue waits for the work. With asynchronous, the code returns emmidiately without waiting for the task to be complete.

> On every dispatch queue, tasks will be executed in the same order as you add them to the queue (FIFO) the first task in the line will be executed first but 
> the task completion is not guaranteed. task completion is up to the code complexity. not order.

#### How to tell that a function is synchronous vs. asynchronous.

There are a couple of key components for each. Keep in mind that these are the common cases - there are outliers.

**Key components for a synchronous call/function:**
- You can store the value of the call/function as a value -- there's a return type.
- There usually are no completion handlers.

**Key components for an asynchronous call/function:**
- The function does not contain a return type but rather a completion block.
- When calling the function, you usually don't store it in a variable, but you get it's result from a completion block.

> **Important**:
> The function `dataWithContentsOfURL:(NSURL *)url` is synchronous
> which means if you call network based URLs, it shouldn't be done on the main thread as it will result in latency.
> Often times, I'd see this call when creating a UIImage type from an image URL which isn't handled on the background thread. This can be looked across as you may think it's done asynchronously - which it isn't!\
> Read further on `dataWithContentsOfURL:(NSURL *)url` [on Apple Docs](https://developer.apple.com/documentation/foundation/nsdata/1547245-datawithcontentsofurl)\
> We want to make sure that there's never an asynchronous call on the main thread as it will cause a short latency or long app freeze depending on the task and user's network.


### Terminoligy

From [The Documentation Archive](https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008091)

- The term *thread* is used to refer to a separate path of execution for code. The underlying implementation for threads in OS X is based on the POSIX threads API.
- The term *process* is used to refer to a running executable, which can encompass multiple threads.
- The term *task* is used to refer to the abstract concept of work that needs to be performed.


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

### Serial Queues
Also known as *private dispatch queues* executes one task at a time in the order that they were added to the queue. The currently executed tasks are run on distinct threads and serial queues are often used to synchronize access to a specific resource.

### Concurrent queues
Also known as *global dispatch queues* execute one or more tasks concurrently. But tasks are still started in order of how they were added. 

### Main Dispatch Queue 
The main dispatch queue is a globally available serial queue that executes tasks on the application’s main thread. 

### QoS

A Quality of Service class allows you to categorize work to be performed by NSOperation, NSOperationQueue, NSThread objects, and dispatch queues.\
When setting up global dispatch queues, you don't specify the priority directly but you are required to specify a quality of service which guides GCD into determining the priority level to give the task.\
Higher priority work requires more energy so choose accordingly to the use case as it directly impacts apps responsiveness and app energy.\
GCD provides 4 quality of services:

- ```.userInteractive```: user-interactive tasks, such as animations, event handling, or updating your app's user interface. work that is interacting with the user and requires instant visual layout such as tasks that update the UI on the main thread; refreshing the ui, performing animations. Focuses on responsiveness and performance.
- ```.userInitiated```: tasks that prevent the user from actively using your app. Work that the user initiated and requires immediate results. e.x. opening a document, doing something when user taps on button. The work is required to continue  user interaction. Focuses on responsiveness and performance.
- ```.utility```: work that may take some time that doesn't require emmediate results. e.g. downloading or importing data. Focuses on a balance between responsiveness, performance, and energy efficiency.
- ```.background```: for maintenance or cleanup tasks that you create. work that operates in the background and isn't visible to the user. e.x. indexing, synchronizing, and backups. Focuses on energy efficiency.

*Explanation*: Use QoS level of userInitiated or lower for optimization.

And 2 special quality of services:
- ```.default```: the priority falls between user-initiated and utility.
- ```.unspecified```: this represents the absence of qos and cues the system an environmental qos should be inferred.
These two special cases we won't be exposed to but they do exist.

> If your app uses operations and queues to perform work, you can specify a QoS for that work. 
> NSOperation and NSOperationQueue both have a property called ```qualityOfService``` of type ```NSQualityOfService``` 
> ```swift
> let myOperation: NSOperation = MyOperation()
> myOperation.qualityOfService = .Utility
> ```
> DisptachQueues have a property you declare when calling initializing the queue
> ```swift
> let queue = DispatchQueue.global(qos: .utility)
> ```
> NSThread have a property of ```qualityOfService``` of type ```NSQualityOfService```
> ```swift
> let queue = DispatchQueue.global(qos: .utility)
> ```

#### Priority Inversions
When high priority work becomes dependant on lower priority work, or it becomes the result of lower priority work, a *priority inversion* occurs. As a result, blocking, spinning, or polling may occur.\
In the case of synchronous work, the system will resolve by raising the QoS of the lower priority queue for the duration of the inversion. \
In the case of asynchronous work, the system will resolve on a serial queue.

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

Sometimes we need to execute all heavy tasks before being able to continue. This is where DispatchGroups come in handy. You can call the `wait` or `notify` method to know that all tasks have complete in the group.\
Dispatch groups are used when you have a load of things you want to do that can happen all at once.

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

Semaphores acts as the decision maker about what shared resource gets displayed on the thread indicating with the wait() and signal() function. They consist of threads queue and counter value.
- *Threads Queue*: Used by the semaphore to keep track of what has acces to the shared resource first. This is in FIFO order. (First thread entered will be the first to get access to the shared resource once avaiable)
- *Counter Value*: used by the semaphore to decide if a thread should get access to the shared resource or not. This value changes when called *signal()* or *wait()* functions.\
\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Call *wait()* before using the shared resource. To ask if the shared resource is available or not. should not be called on the main thread since it will freeze the app.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Call *signal()* after using the resource. Signaling the semaphore that we are done interacting with it.

**Thread safe**: *Code that can be safely called from multiple threads and not cause any issues.*

- Below Is a sample simulation of 2 people using a Switch--shared resource.

```swift
let semaphore = DispatchSemaphore(value: 1)
DispatchQueue.global().async {
    semaphore.wait()
    sleep(1) // Person 1 playing with Switch
    print("Person 1 - done with Switch")
    semaphore.signal()
}
DispatchQueue.global().async {
    semaphore.wait()
    print("Person 2 - wait finished")
    sleep(1) // Person 2 playing with Switch
    print("Person 2 - done with Switch")
    semaphore.signal()
}
```

*Explanation*: declare the semaphore counter value to 1 indicating that we only want the resource to be accessible by one thread. Then we call the ```wait()``` to make sure we can access the resource and execute the task and don't forget to call the ```signal()``` to signal that we are done using the resource.\
Semaphores are used when you have a resource that can be accessed by N threads at the same time. They are used mainly for multiple tasks that use the same resource.

More on using semaphores [here](https://github.com/RinniSwift/iOS/blob/master/Concurrency/semaphores.playground/Contents.swift).

Sometimes you want to limit work in progress when you know there are a lot of tasks you want to execute during the same time without trying to thread explode — which is when the pool hits the limit of 65 threads.\
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

> :question: **Questions**\
> - How many types of queues are there?\
>       *There are two types. Serial queues and concurrent queues. Serial queues execute tasks after the one before it has completed. Concurrent queues don't wait for one to finish to execute.*
> - How many queues are pre-created in GCD?\
>       *There are initially 5 queues ready to use, 1 serial queue — main queue, and 4 concurrent queues having different priorities — high, default, low, background.*
> - Is the main queue a serial or concurrent queue?\
>       *It's a serial queue. This is where all UI related tasks are executed.*
> - What is a thread explosion, and how can you limit this?\
>       *Thread explosion is when the pool exceeds the limit of 65 threads. This can be handled and limited by using a semaphore by giving the value to the semaphore to limit it down.*

# Combine Framework

Combine is an API for processing values over time. This is used to simplify code with dealing with things like delegates, notifications, timers, completion blocks, and call backs.

This is the most similar to the reactive framework (RXSwift) but Apple has made it's own.

Combine is very similar to reactive programming in the sense that observe values over time on asynchronous events and operations.

There're mainly five pieces to the combine framework

- A ***publisher*** is an observable object that emits values over time and can optionally complete when there are no more values or when encountered an error.
- ***Subscribers*** are objects or closures that receive a stream of value, completion, or failure events from a publisher.

    There are two built in subscribers in Combine. 

    - *sink*
    - *assign*

    Both *sink* and *assign* conform to the cancellable protocol.

    There's also a subscriber built in SwiftUI — onReceive.

- A ***subject*** is a ***mutable*** object that can be used to send new values through a publisher.
- ***Operators*** are reactive chains that applies some transform to the data that was sent to it.
- A ***cancellable*** is used to keep track of a subscription to a given publisher, and needs to remain as long as we want the subscription to remain active.

*Create a publisher*

```swift
let url = URL(string: "https://api.github.com/repos/johnsundell/publish")!
let publisher = URLSesssion.shared.dataTaskPublisher(for: url)
```

*Attach subscriptions to it using the `sink` API*

```swift
let cancellable = publisher.sink {
   receiveCompletion: { completion in
      print(completion)
   },
   receiveValue: { value in 
      print(value)
   }
}
```

`receiveCompletion` gets called once when the publisher has completed.

`receiveValue` gets called multiple times when the publisher has observed a change.

When creating a new subscription, with the sink API, it always returns an object that conforms to the `cancellable` protocol. When the object is deallocated, the subscription will automatically get canceled. But you can also cancel it by calling the `cancel()`.

The `completion` being a result type

The `value` being a tuple containing the downloaded data as well as the network response. `(Data, URLResponse)`

*Use the **map** operator to extract data from the publisher as well as other operators that can work with the publisher. e.g. **decode***

```swift
let dataPublisher = publisher.map(\.data) 
let repoPublisher = publisher.map(\.data).decode(type: Repo.self, decoder: JSONDecoder())
```

*Now we've created a repoPublisher that emits Repo types as it's values. So we can call like below*

```swift
let cancellable = repoPublisher.sink {
   receiveCompletion: { completion in
      print(completion)
   },
   receiveValue: { repo in // repo is of type `Repo`
      print(repo)
   }
}
```

*And we can add some extra to edit the code*

```swift
let repoPublisher = publisher.map(\.data).decode(type: Repo.self, decoder: JSONDecoder()).receive(on: DispatchQueue.main)
```

Now within the receiveValue completion, it will be handled on the main queue.

> :bulb: Combine is very useful when wanting to extract out access information in the completion. Which is what we want. To have as little code as possible.

*[next page: url components](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/urlComponents.md)*
