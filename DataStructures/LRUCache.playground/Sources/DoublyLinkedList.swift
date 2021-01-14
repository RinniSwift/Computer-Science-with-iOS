import Foundation
import XCTest

/// A Node class to represent data objects in the LinkedList class
public class Node<T> {
    public var value: T
    var previous: Node<T>?
    var next: Node<T>?

    init(value: T) {
        self.value = value
    }
}

/// An implementation of a generic doubly linkedList.
public class DoublyLinkedList<T> {
    public var head: Node<T>?
    public var tail: Node<T>?
    var isEmpty: Bool {
        return head == nil && tail == nil
    }

    public var count: Int = 0

    public init() {}

    /// print the values of each node in order in the LinkedList
    public func prettyPrint() {
        var nodes = [T]()
        var currNode = head
        while currNode != nil {
            nodes.append(currNode!.value)
            currNode = currNode?.next
        }
        print(nodes)
    }

    /// traverses the nodes and returns the node at the given index and nil if no nodes are found in the LinkedList.
    /// The head starting at index 0.
    func node(at index: Int) -> Node<T>? {
        guard !isEmpty || index == 0 else {
            return head
        }

        var node = head
        for _ in stride(from: 0, to: index, by: 1) {
            node = node?.next
        }

        return node
    }

    /// Adds a node from the value to the LinkedList.
    func add(value: T) {
        let node = Node(value: value)

        guard !isEmpty else {
            head = node
            tail = node
            count += 1
            return
        }

        node.previous = tail
        tail?.next = node
        tail = node
        count += 1
    }

    /// The head starting at index 0
    /// returns bool indicating wether or not the insert was successful.
    public func insert(value: T, at index: Int) -> Bool {
        guard !isEmpty else {
            add(value: value)
            return true
        }

        guard case 0..<count = index else {
            print("NOT WITHIN HERE")
            return false
        }

        let newNode = Node(value: value)

        var currNode = head
        for _ in stride(from: 0, to: index - 1, by: 1) {
            currNode = currNode?.next
        }

        if currNode === head {
            if head === tail {
                newNode.next = head
                head?.previous = newNode
                head = newNode
            } else {
                newNode.next = head
                head = newNode
            }

            count += 1
            return true
        }

        newNode.previous = currNode
        newNode.next = currNode?.next
        currNode?.next?.previous = newNode
        currNode?.next = newNode

        count += 1
        return true
    }

    /// The head of the LinkedList starting at index 0
    /// Returns bool indicating wether or not the remove was successful
    func remove(at index: Int) -> Bool {
        guard case 0..<count = index else {
            return false
        }

        var currNode = head
        for _ in stride(from: 0, to: index, by: 1) {
            currNode = currNode?.next
        }

        if currNode === head {
            if head === tail {
               head = nil
               tail = nil
            } else {
               head?.next?.previous = nil
               head = head?.next
            }
            count -= 1
            return true
        }

        currNode?.previous?.next = currNode?.next
        currNode?.next?.previous = currNode?.previous

        count -= 1
        return true
    }

    /// Removes the last element from the linkedlist.
    public func remove() -> Bool {
        guard !isEmpty else {
            return false
        }

        if head === tail {
            head = nil
            tail = nil
            count -= 1
            return true
        }

        tail?.previous?.next = nil
        tail = tail?.previous

        count -= 1
        return true
    }
}
