
# :couple: Queue

1. What is a queue
2. API — interface of a queue
3. Understand the different implementations
5. Implemention using Swift

## What is a queue?

A queue is a linear data structure which follows the order of FiFO (First In First Out) order. Queues are used when things don't have to be processed imedietely (similar to BFS).

## Key functionality

- `enqueue`
- `dequeue`
- `peek`
- `isEmpty`

## Different implementations

1. Using an **array**

    queues front is at index 0

    enqueue: append: O(1) amortized

    dequeue: append: O(n)

    queues front is at index -1 (last)

    enqueue: insert:at: O(n)

    dequeue: pop(): O(1)

2. Using **2 stacks**

    enqueue: O(1)

    dequeue: O(1) emortized

3. Using **1 stack**

### Using 2 stacks

let's make stackOne be the enqueue stack and stackTwo be the dequeue stack. 
whenever you enqueue to a queue, you will push it to stackOne.
whenever you dequeue from a queue, you will:
  - check if stackTwo is empty, if it's not, pop the element from the stack
  - if it's empty
      - if stackOne is empty, return nil 
      - if stackOne is not empty, recurse through stackOne and pop and push the elements to stackTwo.

## Where is it used?

### Implementation

[Implementation in Swift](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/DataStructures/Queue.playground/Contents.swift)
