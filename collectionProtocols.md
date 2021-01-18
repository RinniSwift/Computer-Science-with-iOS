*[previous page: swift keywords](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/swiftKeywords.md)*

# Collection Protocols

#### Sequence Protocol
A sequence protocol lets you iterate over a the same type of values. Most common way is a *for-in* loop. Implement Sequence with operations that have to depend on sequential access to a series of values.\
Making your own custom types conform to the Sequence protocol enables the *for-in* loop and *contains* method. To add the conformance to your own custom type, you must provide a ```makeIterator()``` method that returns an *iterator*.

```Swift
protocol Sequence {
   associatedtype Iterator: IteratorProtocol
   asociatedtype Subsequence

   __consuming func makeIterator() -> Self.Iterator
}
``` 

#### Iterator Protocol
Sequences provide access to their elements by creating an iterator. The iterator produces the values of the sequence one at a time and keeps track of its iteration state. The only method defined in the *Iterator Protocol* is ```next()``` which must return the next element on each subsequent call or nil. 

```swift
protocol IteratorProtocol {
   associatedtype Element
   mutating func next() -> Self.Element?
}
```

> **Iterators and value semantics**. All iterators in the example have value semantics. This means that if there is a copy, the iterators will act independantly of each other. But *without value semantics*(reference semantics), the original and the copy don't act indipendently. The *storage of the box* is actually shared between the two iterators. Example of a reference semantic is ```AnyIterator``` it wraps the iterator in an internal box object(a class instance)
> Mostly we create iterators implicitly more than explicitly through a for loop. 

This is what a for loop does under the hood: the compiler creates a fresh iterator for the sequence and calls next on the iterator repeatedly until nil is returned which looks like:

```swift
var iterator = someSequence.makeIterator()
while let element = iterator.next() {
   doSomething(with: element)
}
```
This iterator can be used explicitly instead of a for-in loop by calling the iterators next until it returns nil.

---

> **Activity**\
> Implementing a string iterator that iterates over and increments the prefix

```swift
struct PrefixIterator: IteratorProtocol {

   // protocol stub--this is not necessary since it can infer the type when called the PrefixSequence
   // typealias Element = Substring
   
   let string: String
   var offset: String.index

   init(string: String) {
       self.string = string
       self.offset = string.startIndex
   }

   // protocol stub
   mutating func next() -> Substring? {
       guard offset < string.endIndex else { return nil }
       offset = string.index(after: offset)
       return string[string.startIndex..<offset]
   }
}
```
> Now that we have the iterator protocol, we can use this in the makeIterator() method in a 'sequence'
```swift
struct PrefixSequence: Sequence {
   let string: String

   func makeIterator() -> PrefixIterator {
       return PrefixIterator(string)
   }
}
```
> Now we can iterate over the sequence--in this case, a string-- and return all substrings from start to incrementing until the last elements.
```swift
for prefix in Prefixsequence(string: "Rinni") {
   print(prefix)
}
// "R"
// "Ri"
// "Rin"
// "Rinn"
// "Rinni"
```
> We have just created infinite sequences. We can also construct another function or parameter to slice off the finite piece.

---

**AnyIterator** is an iterator that wraps another iterator. (does not have value semantics) It also has a second initializer that takes the next function directly as its argument. e.g. We can define the fibonacci iterator as a function that returns an ```AnyIterator```:

```swift
func fibsIterator() -> AnyIterator<Int> {
   var state = (0, 1)
   return AnyIterator {
       let upcomingNumber = state.0
       state = (state.1, state.0 + state.1)
       return upcomingNumber
   }
}

let fibsSequence = AnySequence(fibsIterator)
Array(fibsSequence.prefix(10)) // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
```

Another alternative is to use the ```sequence(first:next:)``` returns a sequence as the first element as the first argument passed in and ```sequence(state:next:)``` more powerful because we can keep a mutable state around the next closure.

```swift
let randomNumbers = sequence(first: 100) { (previous: UInt32) in
   let newValue = UInt32.randome(in: 0...previous)
   guard newValue > 0 else { return nil }
   return newValue
}
Array(randomNumbers) 

let fibsSequence = sequence(state: (0, 1)) {
   // compiler needs type inference help here
   (state: inout(Int, Int)) -> Int? in
   let upcomingNumber = state.0
   state = (state.1, state.0 + state.1)
   return upcomingNumber
}
Array(fibsSequence.prefix(10))
```

**Subsequence**\
*Sequence* has another associated type, named **Subsequence**. Subsequence is used as the return type for operations that return slices of the original sequence.
- ```prefix``` and ```sufix``` returns the first or last n elements
- ```dropFirst``` and ```dropLast``` returns subsequence where the first or last n elements have been removed
- ```split``` break the sequence at the specified seperator and returns an array of subsquences.

#### Collection Protocol
A collection is a stable sequence that can be traversed multiple times. In addition to traversals, collection elements can also be accessed through subsript with an index (arrays). Subscript index are often integers. But there are also indixes which are opaque values (dictionaries, strings) which can be non-intuative. Collection indices form a finite range. Unlike sequences, collections can't be infinite.\
The *Collection* protocol builds on top of *Sequence*. In addition from all the methods inherited from sequence, they have the *count* property. Use the collection conformance for sequence types that are finite.\
*Arrays*, *Dictionaries*, and *Sets* are collections as are *CountableRange* and *UnsafeBufferPointer*.\
With conforming to the collection protocol, the type can have more than 40 methods and properties.
- for-in loop to iterate over elements. ```for x in class/struct {}```
- pass the class/struct to methods that take sequences e.g: ```var a = Array(class/struct)```
- can call methods and properties that extend Sequence: ```map()```, ```flatMap()```, ```filter()```, ```sorted()```, ```joined(separator:)```
- can call methods and properties that extend Collection: ```isEmpty```, ```count```, ```first```

---

> **Activity**\
> Implementing a queue as a collection type.
> Good way to start is to define a protocol that describes what a queue is.

```swift
/// a type that can `enqueue` and `dequeue` elements.
protocol Queue {
   /// the type of elements held in `self`
   associatedtype Element
   /// enqueue `element` to `self`
   mutating func enqueue(_ newElement: Element)
   /// dequeue `element` from `self`
   mutating func dequeue() -> Element?
}
```
> Simply tells us about the definition of a queue. It's defined generically. It can contain any type, represented by the associated type Element. It imposes no restriction on what Element is. 

```swift
/// An efficient variable-size FIFO queue of elements of type `Element`
struct FIFOQueue<T>: Queue {
   typealias Element = T

   private var left: [Element] = []
   private var right: [Element] = []
   
   /// Add an element to the back of the queue.
   /// - Complexity: O(1).
   mutating func enqueue(_ newElement: Element) {
       right.append(newElement)
   }

   /// Removes front of the queue.
   /// Returns `nil` in case of an empty queue.
   /// - Complexity: Amortized O(1).
   mutating func dequeue() -> Element? {
       if left.isEmpty {
          left = right.reversed()
          right.removeAll()
       }
       return left.popLast()
   }
}
```

> This implementation uses a technique of simulating a queue using two stacks(two arrays). Although the reversed function has the ```reversed()``` function, it still amortizes to O(1) since it only reverses the array once the left array is empty
> Conforming to the Collection protocol involves in declaring and methods: ```startIndex```, ```endIndex```,  ```index(after:)```, and ```subscript(position:)```. Creating an extension to the FIFOQueue struct will give you all the functions and properties of a typical collection type.

---

#### ExpressibleByArrayLiteral
This allows users to create the class or struct with array literals. This only requires one property and one initializer: The ```typealias ArrayLiteralElement``` and the ```init(arrayLiteral elements: T...)```

*[next page: collection types](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/collections.md)*
