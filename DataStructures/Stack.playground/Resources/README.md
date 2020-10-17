# Stacks

## What is a stack

A stack is a linear data structure that stores and accesses in an orderly manner.

Stacks are LIFO or FILO order.

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
