*[previous page: enums](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/enums.md)*

# Higher Order Functions

###### Use these collection instances in reference to the following code snippets.
```swift
let numArr = [1, 3, 22, 9, 7]
let nameToScore = ["rin": 9, "sar": 10, "cenz": 9, "ruh": 10, "mike": 7]
```

## Map

Returns the collection containing the results of mapping the input closure over the collection's elements.

> *Does not modify the collection - rather returns a new collection.*

```swift
let fifteenPercentOfNums = numArr.map { Float($0) * 0.15 }
// fifteenPercentOfNums = [0.15, 0.6, 1.35, 3.3000002]

let playersNames = nameToScore.map { $0.key.capitalized }
// playersNames = ["Cenz", "Rin", "Sar", "Ruh", "Mike"]
```

## Filter

Returns the collection containing the existing elements type from the results that match the input closures condition from the collection's elements.

The result in the closure must contain a true/false value.

> *Does not modify the collection - rather returns a new collection.*

```swift
let items = numArr.filter { $0 > 20 }
// items = [22]

let topPlayers = itemsDict.filter { $0.value >= 8 }.keys
// topPlayers = ["ruh", "sar", "rin", "cenz"]
let topPlayersTwo = itemsDict.filter { key, value in
    return value >= 8
}.keys
// topPlayersTwo = ["sar", "ruh", "cenz", "rin"]
```

## Reduce

Returns a single value that is the result of combining all elements using the input closure.

There's two parts to this. 

- `initialResult`: The value to use as the initial accumulative value.
- `nextPartialResult`: The closure that combines the initial accumulative value and an element in the collection.

```swift
let totalNum = numArr.reduce(0, { $0 + $1 })
// total = 36

let totalScore = nameToScore.reduce(0, { $0 + $1.value })
// totalScore = 45
```

> ***Discussion***\
> `0` is the `initialResult` and `$0` is the `nextPartialResult` whereas `$1` is the element.\
> The value `$1` here is a named tuple: `(key: String, value: Int)` where you can access it through .0 and .1 rather than .key and .value respectively as well.

Read more about shorthand argument names [**here**](https://www.notion.so/Computer-Science-in-iOS-a3e8007592944c7e93434a13aaf7e6c6#b28f3b5be4614958a0fa4b5fbf45662c).

## ForEach, contains, sorted, removeAll

*[next page: closures](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/closures.md)*
