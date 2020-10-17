# :link: Linked List

1. What is a linked list
2. API — interface of a linked list
3. Understand the different implementations
4. Understand the different types of a linked list
5. Implemention using Swift

## What is a Linked List

A linked list is a data structure to store data and access data in an orderly manner.

**Key properties of a node:** 

- `data`: a representation of data for each node
- `left`: a node represantation for it's left connected node
- `right`: a node representation for it's right connected node

**Key properties of linked lists are**:

- `head` : the first element in the linked list.
- `tail` : the last element in the linked list.

**Key functionalities of linked lists are**:

- `append`: adding element to the back of the linked list.
- `prepend`: adding element to the start of the linked list.
- `insertAt`: inserting an element at the given index.
- `remove`: removing the last element.
- `removeAt`: removing an element at the given index.
- `retrieveAt`: retrieving the element at the given index.

**Additional functionality**:

- `pretty print`: readable representation of the elements in the linked list orderly.
- `replaceAt`: replace an element at the index of the linked list.
- `count`: number of elements in total stored in the linked list.

## Different types

### Singly Linked Lists

Typically the node/element holds information of it's next node/element.

### Doubly Linked Lists

Typically the node/element holds information of it's next and previous node/element.

This makes some computions faster than singly linked lists. 
An example of this would be `remove()` function, in singly linked lists, it would have to loop until the one before the last to reassign it's head and such — making it `O(n)`, in doubly linked lists, it would just need the data of the tail and reassign properties accordingly — making it constant time `O(1)`

**Linked List**

- Dynamic size
- Fast insertion/deletion
- Non-performant indexing. This is because linked lists can't conform to RandomAccessCollection
- Not as performant in look up since looking up of reference types require more memory space.

**Array**

- Fixed size
- Not as performant of insertion/deletion
- Fast indexing time as arrays conform to RandomAccessCollection protocol — performant random access index traversal.
- Performant lookup time since indexes are continuous.

### Implementation

[Implementation in Swift](https://github.com/RinniSwift/Computer-Science-with-iOS/blob/main/DataStructures/LinkedList.playground/Contents.swift)
