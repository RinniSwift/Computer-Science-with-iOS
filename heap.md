
# :signal_strength: Heap

1. What is a heap
2. API — interface of a heap
3. Understand the different implementations
5. Implemention using Swift

## What is a heap?

A **min heap** or **max heap** are complete binary trees with unique properties.

**Binary tree**s is a tree data structure where each node has at most 2 children.

A **node** in a tree typically consist of properties:
- left node
- right node
- data

heaps are arrays under the hood.

## Key functionality

- `HeapifyUp`: used when deleting an element
- `HeapifyDown`: used when inserting an element

The children of node `n` will be at indexes `2n + 1` and `2n + 2`
The parent of node `n` will be at index `(n - 1) / 2`

## Different implementations

1. Max heap

root node is the maximun value. Left node will be less than the right node.

`add` psuedocode

```swift
// 1. create new node at the end of the heap
// 2. assign new value to the node
// 3. compare the new value to the nodes parent
// 4. if the value is greater than the parent, replace them
// 5. repeat 3 & 4 until top of heap
```

`delete` psuedocode

```swift
// 1. remove root node
// 2. move the last element to the root
// 3. compare the value of the child node with the parent
// 4. if child is more than parent, swap them
// 5. repeat 3 & 4 until
```

2. Min heap

3. Heaps with priority

A heap is frequently used to implement a priority queue

Elements in the heap are partially sorted by their priority. Every node in the tree has a higher priority than its children.

We **add nodes** to the **left most** possible position and **remove nodes** at the **right most** possible position.

**Highest priority element** will always be at the **root node** — index 0

**Removing the highest priority element**

When removing the highest priority element, it leaves back two heaps!  — visually, the tree gets seperated. Therefore, we should go through these steps:

1. Replace the first element with the last element in the heap
2. Remove the last element in the heap
3. Starting from the first element, recursively check it's children if they have a higher priority than itself

    Keep doing step three (*sift down*) until:

    - a former last element has a higher priority than its leafs nodes
    - it becomes the leaf
    1. If the child has a higher priority, swap it out with the parent

**Adding a new element**

1. Add the new element to the lower left most level of the heap.
2. Starting from the new element, we check if the element has a higher priority than its parent, we sift up by swapping place with it's parent.

    Keep doing step two (*sift up*) until:

    1. the new element has a lower priority than it's parent
    2. the new element becomes the root of the heap.

## Where is it used?

### [Implementation in Swift](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/DataStructures/Heap.playground/Contents.swift)
