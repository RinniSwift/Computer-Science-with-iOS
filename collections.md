*[previous page: collection protocols](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/collectionProtocols.md)*

# Collection Types in Swift

We’ve heard a lot about data structures. Data structures are containers that store data in a specific layout. They’re extremely important, given that all programs deal with data and how they’re stored. Therefore, taking into consideration how we store this data is a must—not only in terms of space (i.e. memory consumption) but also time (evaluating how much time we can/cannot exceed).

In each collection, we'll go through:
- It's signature
- What it is
- How it works under the hood
- Different ways of initialization
- Different operations / APIs

## Arrays

`@frozen struct Array<Element>`

An array is an ordered, random-access collection. You use arrays to hold elements of a single type, `Element`.

Arrays reserve a specific amount of memory to hold their contents. Once the capacity is full and you add more elements to the array, the array allocates a larger region of memory and copies its elements into the new storage. This can be time consuming. The new storage size grows exponentially as compared to the old size. Therefore, as the array grows, reallocation occurs less and less often.

<img src="/Images/resizingArrays.png" width="750"/>

As shown in the diagram above, we’re appending “Violet” to the array that’s just about to exceed its capacity. The item doesn’t get added right away, but what happens is new memory is created elsewhere, all items are copied over `O(n)`, and finally the item is added in to the array. This is called **reallocation**: allocating new storage at another region in memory. The array’s size increases exponentially. In Swift, this is called the geometric growth pattern.

So after we’ve appended “Violet”, the array capacity will grow exponentially from 5 to 10. And if we were to append an eleventh item, reallocation happens and the array capacity grows to 20.

### Initializers

```swift
// short hand notation
var names: [String] = []
var namesOne = [String]()

// full type name
var namesTwo: Array<String> = Array()
var namesThree = Array<String>()
var namesFour = Array(repeating: "Rinni", count: 2) // ["Rinni", "Rinni"]
```

- `init()`
- `init<S>(S)`
- `init(repeating:, count:)`

### APIs

- `reserveCapacity(_:)`: add this right after the initialization of the array and before adding elements.

- `capacity`
- `count`
- `isEmpty`
- `first`
- `last`

- `remove(at:) -> Element`
- `removeFirst() -> Element`
- `removeSubrange(_ bounds: Range<Element>)`
- `removeAll(keepingCapacity: Bool)`
- `removeLast() -> Element`
- `popLast() -> Element?`
- `FirstIndex(of:) -> Int?`
- `allSatisfy(where: (Element) -> Bool) -> Bool`
- `contains(_ element:)`
- `first(where:) -> Element?`
- `last(where:) -> Element?`
- `dropFirst() -> ArraySlice<Element>`
- `dropLast() -> ArraySlice<Element>`
- `reverse()`
- `reversed() -> ReversedCollection<Array<Element>>`
- `sort()`
- `sorted() -> [Element]`
- `swapAt(Int, Int)`

> :warning: Note: the `popLast` method would be more safe as it returns an optional element as aposed to the `removeLast` method which returns a non optional -- meaning that if the array were empty, it would crash the app.

*[next page: foundation](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/foundation.md)*
