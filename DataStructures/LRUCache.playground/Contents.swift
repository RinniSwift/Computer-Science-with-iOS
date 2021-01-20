import UIKit
import XCTest

class LRUCache<T: Hashable, U> {

    /// Total capacity of the LRU cache.
    private(set) var capacity: UInt
    /// LinkedList will store elements that are most accessed at the head and least accessed at the tail.
    private(set) var linkedList = DoublyLinkedList<CachePayload<T, U>>()
    /// Dictionary that will store the element, T, at the specified key.
    private(set) var dictionary = [T: Node<CachePayload<T, U>>]()

    /// LRUCache requires a capacity which must be greater than 0
    required init(capacity: UInt) {
        self.capacity = capacity
    }

    /// Sets the specified value at the specified key in the cache.
    func setObject(for key: T, value: U) {
        let element = CachePayload(key: key, value: value)
        let node = Node(value: element)

        if let existingNode = dictionary[key] {
            // move the existing node to head
            linkedList.moveToHead(node: existingNode)
            linkedList.head?.payload.value = value
            dictionary[key] = node
        } else {
            if linkedList.count == capacity {
                if let leastAccessedKey = linkedList.tail?.payload.key {
                    dictionary[leastAccessedKey] = nil
                }
                linkedList.remove()
            }

            linkedList.insert(node: node, at: 0)
            dictionary[key] = node
        }
    }

    /// Returns the element at the specified key. Nil if it doesn't exist.
    func retrieveObject(at key: T) -> U? {
        guard let existingNode = dictionary[key] else {
            return nil
        }

        linkedList.moveToHead(node: existingNode)
        return existingNode.payload.value
    }
}



class TestLRUCache: XCTestCase {

    let cache = LRUCache<String, Int>(capacity: 5)

    func testEmptyCache() {
        XCTAssert(cache.linkedList.head == nil)
        XCTAssert(cache.linkedList.tail == nil)
        XCTAssert(cache.linkedList.count == 0)
    }

    func testAddingOneObject() {
        cache.setObject(for: "Rinni", value: 21)

        XCTAssert(cache.linkedList.head?.payload.key == "Rinni")
        XCTAssert(cache.linkedList.tail?.payload.key == "Rinni")
        XCTAssert(cache.linkedList.head?.payload.value == 21)
        XCTAssert(cache.linkedList.tail?.payload.value == 21)
        XCTAssert(cache.linkedList.count == 1)

        XCTAssert(cache.dictionary["Rinni"]?.payload.value == 21)
    }

    func testAddingTwoObjects() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)

        XCTAssert(cache.linkedList.head?.payload.key == "Sarin")
        XCTAssert(cache.linkedList.tail?.payload.key == "Rinni")
        XCTAssert(cache.linkedList.head?.payload.value == 21)
        XCTAssert(cache.linkedList.tail?.payload.value == 21)
        XCTAssert(cache.linkedList.count == 2)

        XCTAssert(cache.dictionary["Rinni"]?.payload.value == 21)
        XCTAssert(cache.dictionary["Sarin"]?.payload.value == 21)
    }

    func testAddingDuplicateObject() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)
        cache.setObject(for: "Sarin", value: 20)

        // (Sarin: 20) -> (Rinni: 21)
//        cache.linkedList.prettyPrint()
//        print("\n")

        XCTAssert(cache.linkedList.head?.payload.key == "Sarin")
        XCTAssert(cache.linkedList.tail?.payload.key == "Rinni")
        XCTAssert(cache.linkedList.head?.payload.value == 20)
        XCTAssert(cache.linkedList.tail?.payload.value == 21)
        XCTAssert(cache.linkedList.count == 2)

        XCTAssert(cache.dictionary.count == 2)
        XCTAssert(cache.dictionary["Rinni"]?.payload.value == 21)
        XCTAssert(cache.dictionary["Sarin"]?.payload.value == 20)
    }

    func testAddingDuplicateObjectToAlmostFullCache() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)
        cache.setObject(for: "Cenz", value: 23)
        cache.setObject(for: "Ruhsane", value: 22)
        cache.setObject(for: "Sarin", value: 2)

        // (Sarin: 2) -> (Ruhsane: 22) -> (Cenz: 23) -> (Rinni: 21)
//        cache.linkedList.prettyPrint()
//        print("\n")

        XCTAssert(cache.linkedList.head?.payload.key == "Sarin")
        XCTAssert(cache.linkedList.tail?.payload.key == "Rinni")
        XCTAssert(cache.linkedList.head?.payload.value == 2)
        XCTAssert(cache.linkedList.tail?.payload.value == 21)
        XCTAssert(cache.linkedList.count == 4)

        XCTAssert(cache.dictionary["Rinni"]?.payload.value == 21)
        XCTAssert(cache.dictionary["Sarin"]?.payload.value == 2)
        XCTAssert(cache.dictionary["Cenz"]?.payload.value == 23)
        XCTAssert(cache.dictionary["Ruhsane"]?.payload.value == 22)
    }

    func testAddingDuplicateObjectToFullCache() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)
        cache.setObject(for: "Cenz", value: 23)
        cache.setObject(for: "Ruhsane", value: 22)
        cache.setObject(for: "Nick", value: 23)
        cache.setObject(for: "Sarin", value: 2)

        // (Sarin: 2) -> (Nick: 23) -> (Ruhsane: 22) -> (Cenz: 23) -> (Rinni: 21)
//        cache.linkedList.prettyPrint()
//        print("\n")

        XCTAssert(cache.linkedList.head?.payload.key == "Sarin")
        XCTAssert(cache.linkedList.tail?.payload.key == "Rinni")
        XCTAssert(cache.linkedList.head?.payload.value == 2)
        XCTAssert(cache.linkedList.tail?.payload.value == 21)
        XCTAssert(cache.linkedList.count == 5)

        XCTAssert(cache.dictionary.count == 5)
        XCTAssert(cache.dictionary["Rinni"]?.payload.value == 21)
        XCTAssert(cache.dictionary["Sarin"]?.payload.value == 2)
        XCTAssert(cache.dictionary["Cenz"]?.payload.value == 23)
        XCTAssert(cache.dictionary["Ruhsane"]?.payload.value == 22)
        XCTAssert(cache.dictionary["Nick"]?.payload.value == 23)
    }

    func testAddingObjectToFullCache() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)
        cache.setObject(for: "Cenz", value: 23)
        cache.setObject(for: "Ruhsane", value: 22)
        cache.setObject(for: "Nick", value: 23)
        cache.setObject(for: "Brian", value: 222)

        // (Brian: 222) -> (Nick: 23) -> (Ruhsane: 22) -> (Cenz: 23) -> (Sarin: 21)
//        cache.linkedList.prettyPrint()
//        print("\n")

        XCTAssert(cache.linkedList.head?.payload.key == "Brian")
        XCTAssert(cache.linkedList.tail?.payload.key == "Sarin")
        XCTAssert(cache.linkedList.head?.payload.value == 222)
        XCTAssert(cache.linkedList.tail?.payload.value == 21)
        XCTAssert(cache.linkedList.count == 5)

        XCTAssert(cache.dictionary.count == 5)
        XCTAssert(cache.dictionary["Rinni"]?.payload.value == nil)
        XCTAssert(cache.dictionary["Sarin"]?.payload.value == 21)
        XCTAssert(cache.dictionary["Cenz"]?.payload.value == 23)
        XCTAssert(cache.dictionary["Ruhsane"]?.payload.value == 22)
        XCTAssert(cache.dictionary["Nick"]?.payload.value == 23)
        XCTAssert(cache.dictionary["Brian"]?.payload.value == 222)
    }

    func testAddingDuplicateObjectToFullerCache() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)
        cache.setObject(for: "Cenz", value: 23)
        cache.setObject(for: "Ruhsane", value: 22)
        cache.setObject(for: "Nick", value: 23)
        cache.setObject(for: "Brian", value: 222)
        cache.setObject(for: "Nick", value: 2)

        // (Nick: 2) -> (Brian: 222) -> (Ruhsane: 22) -> (Cenz: 23) -> (Sarin: 21)
//        cache.linkedList.prettyPrint()
//        print("\n")

        XCTAssert(cache.linkedList.head?.payload.key == "Nick")
        XCTAssert(cache.linkedList.tail?.payload.key == "Sarin")
        XCTAssert(cache.linkedList.head?.payload.value == 2)
        XCTAssert(cache.linkedList.tail?.payload.value == 21)
        XCTAssert(cache.linkedList.count == 5)

        XCTAssert(cache.dictionary.count == 5)
        XCTAssert(cache.dictionary["Rinni"]?.payload.value == nil)
        XCTAssert(cache.dictionary["Sarin"]?.payload.value == 21)
        XCTAssert(cache.dictionary["Cenz"]?.payload.value == 23)
        XCTAssert(cache.dictionary["Ruhsane"]?.payload.value == 22)
        XCTAssert(cache.dictionary["Nick"]?.payload.value == 2)
        XCTAssert(cache.dictionary["Brian"]?.payload.value == 222)
    }

    func testAccessingAnElement() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)
        cache.setObject(for: "Cenz", value: 23)
        cache.setObject(for: "Ruhsane", value: 22)

        XCTAssert(cache.retrieveObject(at: "Cenz") == 23)


        // (Sarin: 2) -> (Ruhsane: 22) -> (Cenz: 23) -> (Rinni: 21)
        cache.linkedList.prettyPrint()
        print("\n")
    }
}

//TestLRUCache.defaultTestSuite.run()
TestDoublyLinkedList.defaultTestSuite.run()
