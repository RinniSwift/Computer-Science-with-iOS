# Computer-Science-with-iOS


# iOS Knowledge
*A collection of iOS knowledge bellow.*

# [Memory Management](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/memoryManagement.md)

# [Reference and Value Types](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/referenceAndValueTypes.md)


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
