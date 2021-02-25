import Foundation
import XCTest


class Node<T: Comparable> {

    private(set) var data: T
    var next: Node<T>?

    init(_ data: T) {
        self.data = data
    } 

}

class LinkedList<T: Comparable> {

    // MARK: Properties

    var head: Node<T>?
    var tail: Node<T>?
    var count: Int = 0

    // MARK: Functions

    /// Adding an element to the back of the linked list.
    func append(_ data: T) {
        let newNode = Node(data)
        tail == nil ? (head = newNode) : (tail?.next = newNode)
        tail = newNode
        count += 1
    }

    /// Adding an element to the start of the linked list.
    func prepend(_ data: T) {
        let newNode = Node(data)
        head == nil ? (tail = newNode) : (newNode.next = head)
        head = newNode
        count += 1
    }

    /// Inserting an element at the specified index.
    /// Returns a bool indicating successful or non successful insertion.
    /// Warning: Index must be within bounds.
    func insert(data: T, at index: Int) -> Bool {
        guard index >= 0 && index <= count else {
            return false
        }

        if index == 0 {
            prepend(data)
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
    func remove() {
        guard count > 0 else {
            return
        }

        var currNode = head

        if head === tail {
            head = nil
            tail = nil
            count -= 1
            return
        }

        while currNode?.next !== tail {
            currNode = currNode?.next
        }

        currNode?.next = nil
        tail = currNode
        count -= 1
    }

    /// Remove the element at the specified index.
    /// Returns a bool indicating successful or non successful removal.
    func remove(at index: Int) -> Bool {
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
    func retrieve(at index: Int) -> Node<T>? {
        var currNode = head

        for _ in 0..<index {
            currNode = currNode?.next
        }

        return currNode
    }

    func prettyPrint() -> String {
        var prettyPrintStr: String = ""

        var currNode = head

        while let cNode = currNode {
            prettyPrintStr += "(\(String(describing: cNode.data))) "
            currNode = currNode?.next
        }

        return prettyPrintStr
    }
}


// MARK: - Testing

class TestLinkedList: XCTestCase {
    let linkedList = LinkedList<Character>()

    func testHeadAndTail() {
        linkedList.append("A")
        XCTAssert(linkedList.head === linkedList.tail)
        XCTAssert(linkedList.count == 1)
    }

    func testAppend() {
        linkedList.append("A")
        linkedList.append("B")
        XCTAssert(linkedList.head?.data == "A")
        XCTAssert(linkedList.tail?.data == "B")

        XCTAssert(linkedList.count == 2)
    }

    func testPrepend() {
        linkedList.append("A")
        linkedList.append("B")
        linkedList.prepend("C")
        XCTAssert(linkedList.head?.data == "C")
        XCTAssert(linkedList.tail?.data == "B")

        XCTAssert(linkedList.count == 3)

        linkedList.prepend("D")
        XCTAssert(linkedList.head?.data == "D")
        XCTAssert(linkedList.tail?.data == "B")

        XCTAssert(linkedList.count == 4)
    }

    func testInsertAt() {
        linkedList.append("A")
        linkedList.append("B")
        linkedList.append("D")

        linkedList.insert(data: "C", at: 2)

        XCTAssert(linkedList.prettyPrint() == "(A) (B) (C) (D) ")
        XCTAssert(linkedList.head?.data == "A")
        XCTAssert(linkedList.tail?.data == "D")

        XCTAssert(linkedList.count == 4)
    }

    func testInsertAtWhenNil() {
        linkedList.insert(data: "C", at: 0)

        XCTAssert(linkedList.head?.data == "C")
        XCTAssert(linkedList.tail?.data == "C")

        XCTAssert(linkedList.count == 1)
    }

    func testRemove() {
        linkedList.append("A")
        linkedList.append("B")
        linkedList.append("C")

        linkedList.remove()

        XCTAssert(linkedList.head?.data == "A")
        XCTAssert(linkedList.tail?.data == "B")

        XCTAssert(linkedList.count == 2)
    }

    func testRemoveWhenNil() {
        linkedList.remove()

        XCTAssert(linkedList.head == nil)
        XCTAssert(linkedList.tail == nil)
        XCTAssert(linkedList.count == 0)
    }

    func testRemoveAt() {
        linkedList.append("A")
        linkedList.append("B")
        linkedList.append("C")

        linkedList.remove(at: 2)

        XCTAssert(linkedList.head?.data == "A")
        XCTAssert(linkedList.tail?.data == "B")

        XCTAssert(linkedList.count == 2)
    }

    func testRemoveAtWhenNil() {
        XCTAssert(linkedList.remove(at: 0) == false)
        XCTAssert(linkedList.count == 0)
    }

    func testRetrieveAt() {
        linkedList.append("A")
        linkedList.append("B")
        linkedList.append("C")

        XCTAssert(linkedList.retrieve(at: 0)?.data == "A")
        XCTAssert(linkedList.retrieve(at: 1)?.data == "B")
        XCTAssert(linkedList.retrieve(at: 2)?.data == "C")

        linkedList.remove()
        linkedList.remove()
        linkedList.remove()

        XCTAssert(linkedList.count == 0)
        XCTAssert(linkedList.retrieve(at: 0) == nil)
    }
}

TestLinkedList.defaultTestSuite.run()
