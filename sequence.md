*[previous page: integer](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/integer.md)*

# Sequence
*Protocol*

> A type that provides sequential, iterated access to its elements.\
> [Apple Docs](https://developer.apple.com/documentation/swift/sequence)

The sequence protocol comes with default APIs that depend on sequential access. Examples are:
- `contains(_:)`

To create your custom sequence which will enable you to more handy APIs, conform to the `Sequence` and `IteratorProtocol`.

- `Sequence`: enables many useful operations, like for-in looping and the contains method, without much effort. Since sequence requires an associated type of `Iterator: IteratorProtocol`, conform to that as well;
- `IteratorProtocol`: For use of the `next()` method which returns either an element or nil if the iterator is finished returning elements of the sequence.
    

#### `IteratorProtocol` Requirements:
- `associatedtype Element`
- `func next() -> Self.Element?`

#### `Sequence` Requirements:
- `associatedtype Iterator` `where Iterator: IteratorProtocol`
- `func makeIterator() -> Self.Iterator`
- `associatedtype Element`

---


What you might see as a simple for-in loop like so:

```swift
let names = ["Cenz", "Rinni", "Sarin", "Ruh"]

for name in names {
    print(name)
}
```

*Under the hood*, Swift uses the array's iterator to loop over the contents of the array like so:

```swift
var arrayIterator = names.makeIterator()
while let name = arrayIterator.next() {
    print(name)
}

// `arrayIterator` is an instance of the array's iterator.
// The while loop calls the `next()` method repeatedly and exiting when the next returns nil.
```

### Create one yourself

Let's say we have a Stack. And figured that it would be helpful to not only see what's on top of the stack, but also what's within the stack in order of top to bottom. This is where making stack a `Sequence` comes in handy.

The original code for the Stack is below. And we'll start building on top of that to make sure it's a sequence.

```swift
struct Stack<T> {

    private var count = 0
    private var array = Array<T>()

    /// Adds an item to the stack.
    mutating func push(_ element: T) {
        count += 1
        array.append(element)
    }

    /// Removes an item from the stack.
    mutating func pop() {
        array.popLast() != nil ? count -= 1 : ()
    }

    /// Returns the top element of the stack.
    func peek() -> T? {
        return array.last
    }

    /// Returns bool indicating wether the stack is empty or not.
    func isEmpty() -> Bool {
        return count == 0
    }
}
```

You might be thinking why not just use the arrays sequence. And yes, in the real world it probably would be best to use what Swift has provided with. But it's always cool to see it in action + to get into the hang of this kind of architect!

So let's start by creating a `IteratorProtocol` type.

```swift
struct StackIterator<T>: IteratorProtocol {

    typealias Element = T
    private var stack: Stack<T>
    private var count: Int

    init(stack: Stack<T>) {
        self.stack = stack
        self.count = stack.array.count - 1
    }

    mutating func next() -> T? {
        guard !stack.array.isEmpty && count >= 0 else {
            return nil
        }

        defer {
            count -= 1
        }
        return stack.array[count]
    }
}
```

And conforming the Stack to a Sequence protocol.

```swift
extension Stack: Sequence {

    func makeIterator() -> some IteratorProtocol {
        return StackIterator<T>(stack: self)
    }
}
```

Now, the magic begins. Well, not really. But the Stack can fully function as an iterator. Let's see it in action:

```swift
var stack = Stack<Int>()
stack.push(22)
stack.push(23)
for item in stack {
    print(item)
}

// 23
// 22

stack.push(19)
for item in stack {
    print(item)
}

// 19
// 23
// 22
```

*[back](https://github.com/RinniSwift/Computer-Science-with-iOS#iphone-ios-knowledge)*
