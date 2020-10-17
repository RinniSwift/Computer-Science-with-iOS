# :books: Stack

1. What is a stack
2. API — interface of a stack
3. Understand the different implementations
5. Implemention using Swift

## What is a stack?

A stack is a linear data structure that stores and accesses in an orderly manner.

Stacks are LIFO(Last In First Out) order.

## Key functionality

- `Push`: adds an item to the stack.
- `Pop`: removed an item from the stack.
- `Peek`: returns the top element of the stack.
- `isEmpty`: returns bool indicating if the stack is empty or not.

## Different implementations

1. Using an **array**

    ***Pros*:** Easy to implement. Memory is saved as pointers are not involved.

    ***Cons*:** It is not dynamic. It doesn’t grow and shrink depending on needs at runtime.

2. Using a **linked list**

    ***Pros*:** The linked list implementation of stack can grow and shrink according to the needs at runtime.

    ***Cons*:** Requires extra memory due to involvement of pointers.

## Where is it used?

- Function call stack

    You can visualize this as nested functions. functions get pushed on to the call stack, once it's complete to the most nested function, it gets exectuted from there and will result in the most nested function being completed, or returned first, before the other top level functions will complete.

- UINavigationController

    This is a container which is stack based for hierarchical content.

### Implementation

[Implementation in Swift](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/DataStructures/Stack.playground/Contents.swift)
