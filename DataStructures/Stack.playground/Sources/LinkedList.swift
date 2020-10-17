import Foundation

public class Node<T: Comparable> {

    public private(set) var data: T
    var next: Node<T>?

    init(_ data: T) {
        self.data = data
    }

}

public class LinkedList<T: Comparable> {

    // MARK: Properties

    public var head: Node<T>?
    public var tail: Node<T>?
    var count: Int = 0

    // MARK: Initializer

    public init() {}

    // MARK: Functions

    /// Adding an element to the back of the linked list.
    public func append(_ data: T) {
        let newNode = Node(data)
        tail == nil ? (head = newNode) : (tail?.next = newNode)
        tail = newNode
        count += 1
    }

    /// Adding an element to the start of the linked list.
    public func prepend(_ data: T) {
        let newNode = Node(data)
        head == nil ? (tail = newNode) : (newNode.next = head)
        head = newNode
        count += 1
    }

    /// Inserting an element at the specified index.
    /// Returns a bool indicating successful or non successful insertion.
    /// Warning: Index must be within bounds.
    public func insert(data: T, at index: Int) -> Bool {
        guard index >= 0 && index <= count else {
            return false
        }

        if index == 0 {
            append(data)
            return true
        }

        let newNode = Node(data)

        var currNode = head
        var currIter = index-1

        while currIter > 0 {
            currNode = currNode?.next
            currIter -= 1
        }

        newNode.next = currNode?.next
        currNode?.next = newNode

        count += 1
        return true
    }

    /// Remove the last element from the linked list.
    /// Returns bool indicating success of removal.
    public func remove() -> Bool {
        guard count > 0 else {
            return false
        }

        var currNode = head

        if head === tail {
            head = nil
            tail = nil
            count -= 1
            return true
        }

        while currNode?.next !== tail {
            currNode = currNode?.next
        }

        currNode?.next = nil
        tail = currNode
        count -= 1
        return true
    }

    /// Remove the element at the specified index.
    /// Returns a bool indicating successful or non successful removal.
    public func remove(at index: Int) -> Bool {
        guard count > 0 && index < count && index >= 0 else {
            return false
        }

        var currNode = head
        var currIter = index - 1

        while currIter > 0 {
            currNode = currNode?.next
            currIter -= 1
        }

        if currNode?.next === tail {
            tail = currNode
        }
        currNode?.next = currNode?.next?.next

        count -= 1
        return true
    }

    /// Retrieve the element at the specified index.
    public func retrieve(at index: Int) -> Node<T>? {
        var currNode = head

        for _ in 0..<index {
            currNode = currNode?.next
        }

        return currNode
    }

    public func prettyPrint() -> String {
        var prettyPrintStr: String = ""

        var currNode = head

        while let cNode = currNode {
            prettyPrintStr += "(\(String(describing: cNode.data))) "
            currNode = currNode?.next
        }

        return prettyPrintStr
    }
}
