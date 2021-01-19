import UIKit
import XCTest

class LRUCache<T> {

    /// Total capacity of the LRU cache.
    private(set) var capacity: UInt
    /// LinkedList will store elements that are most accessed at the head and least accessed at the tail.
    private(set) var linkedList = DoublyLinkedList<CachePayload<T>>()
    /// Dictionary that will store the element, T, at the specified key.
    private(set) var dictionary = [String: T]()

    /// LRUCache requires a capacity which must be greater than 0
    required init(capacity: UInt) {
        self.capacity = capacity
    }

    /// Sets the specified value at the specified key in the cache.
    func setObject(for key: String, value: T) {
        let element = CachePayload(key: key, value: value)
        if dictionary[key] != nil {
            // move the value to head
            let node = Node(value: element)
            linkedList.moveToHead(node: node)
            dictionary[key] = value
        } else {
            if linkedList.count == capacity {
                if let leastAccessedKey = linkedList.tail?.payload.key {
                    dictionary[leastAccessedKey] = nil
                }
                linkedList.remove()
            }
            linkedList.insert(value: element, at: 0)
            dictionary[key] = value
        }
    }

    /// Returns the element at the specified key. Nil if it doesn't exist.
    func retrieveObject(at key: String) -> T? {
        return dictionary[key]
    }
}



class TestLRUCache: XCTestCase {

    let cache = LRUCache<Int>(capacity: 5)

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

        XCTAssert(cache.dictionary["Rinni"] == 21)
    }

    func testAddingTwoObjects() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)

        XCTAssert(cache.linkedList.head?.payload.key == "Sarin")
        XCTAssert(cache.linkedList.tail?.payload.key == "Rinni")
        XCTAssert(cache.linkedList.head?.payload.value == 21)
        XCTAssert(cache.linkedList.tail?.payload.value == 21)
        XCTAssert(cache.linkedList.count == 2)

        XCTAssert(cache.dictionary["Rinni"] == 21)
        XCTAssert(cache.dictionary["Sarin"] == 21)
    }

    func testAddingDuplicateObject() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)
        cache.setObject(for: "Sarin", value: 20)

        XCTAssert(cache.linkedList.head?.payload.key == "Sarin")
        XCTAssert(cache.linkedList.tail?.payload.key == "Rinni")
        XCTAssert(cache.linkedList.head?.payload.value == 20)
        XCTAssert(cache.linkedList.tail?.payload.value == 21)
        XCTAssert(cache.linkedList.count == 2)

        XCTAssert(cache.dictionary.count == 2)
        XCTAssert(cache.dictionary["Rinni"] == 21)
        XCTAssert(cache.dictionary["Sarin"] == 20)
    }

    func testAddingDuplicateObjectToAlmostFullCache() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)
        cache.setObject(for: "Cenz", value: 23)
        cache.setObject(for: "Ruhsane", value: 22)
        cache.setObject(for: "Sarin", value: 2)

        XCTAssert(cache.linkedList.head?.payload.key == "Sarin")
        XCTAssert(cache.linkedList.tail?.payload.key == "Rinni")
        XCTAssert(cache.linkedList.head?.payload.value == 2)
        XCTAssert(cache.linkedList.tail?.payload.value == 21)
        XCTAssert(cache.linkedList.count == 4)

        XCTAssert(cache.dictionary["Rinni"] == 21)
        XCTAssert(cache.dictionary["Sarin"] == 2)
        XCTAssert(cache.dictionary["Cenz"] == 23)
        XCTAssert(cache.dictionary["Ruhsane"] == 22)
    }

    func testAddingDuplicateObjectToFullCache() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)
        cache.setObject(for: "Cenz", value: 23)
        cache.setObject(for: "Ruhsane", value: 22)
        cache.setObject(for: "Nick", value: 23)
        cache.setObject(for: "Sarin", value: 2)

        XCTAssert(cache.linkedList.head?.payload.key == "Sarin")
        XCTAssert(cache.linkedList.tail?.payload.key == "Rinni")
        XCTAssert(cache.linkedList.head?.payload.value == 2)
        XCTAssert(cache.linkedList.tail?.payload.value == 21)
        XCTAssert(cache.linkedList.count == 5)

        XCTAssert(cache.dictionary.count == 5)
        XCTAssert(cache.dictionary["Rinni"] == 21)
        XCTAssert(cache.dictionary["Sarin"] == 2)
        XCTAssert(cache.dictionary["Cenz"] == 23)
        XCTAssert(cache.dictionary["Ruhsane"] == 22)
        XCTAssert(cache.dictionary["Nick"] == 23)
    }

    func testAddingObjectToFullCache() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)
        cache.setObject(for: "Cenz", value: 23)
        cache.setObject(for: "Ruhsane", value: 22)
        cache.setObject(for: "Nick", value: 23)
        cache.setObject(for: "Brian", value: 222)

        XCTAssert(cache.linkedList.head?.payload.key == "Brian")
        XCTAssert(cache.linkedList.tail?.payload.key == "Sarin")
        XCTAssert(cache.linkedList.head?.payload.value == 222)
        XCTAssert(cache.linkedList.tail?.payload.value == 21)
        XCTAssert(cache.linkedList.count == 5)

        XCTAssert(cache.dictionary.count == 5)
        XCTAssert(cache.dictionary["Rinni"] == nil)
        XCTAssert(cache.dictionary["Sarin"] == 21)
        XCTAssert(cache.dictionary["Cenz"] == 23)
        XCTAssert(cache.dictionary["Ruhsane"] == 22)
        XCTAssert(cache.dictionary["Nick"] == 23)
        XCTAssert(cache.dictionary["Brian"] == 222)
    }

    func testAddingDuplicateObjectToFullerCache() {
        cache.setObject(for: "Rinni", value: 21)
        cache.setObject(for: "Sarin", value: 21)
        cache.setObject(for: "Cenz", value: 23)
        cache.setObject(for: "Ruhsane", value: 22)
        cache.setObject(for: "Nick", value: 23)
        cache.setObject(for: "Brian", value: 222)
        cache.setObject(for: "Nick", value: 2)

        XCTAssert(cache.linkedList.head?.payload.key == "Nick")
        XCTAssert(cache.linkedList.tail?.payload.key == "Sarin")
        XCTAssert(cache.linkedList.head?.payload.value == 2)
        XCTAssert(cache.linkedList.tail?.payload.value == 21)
        XCTAssert(cache.linkedList.count == 5)

        XCTAssert(cache.dictionary.count == 5)
        XCTAssert(cache.dictionary["Rinni"] == nil)
        XCTAssert(cache.dictionary["Sarin"] == 21)
        XCTAssert(cache.dictionary["Cenz"] == 23)
        XCTAssert(cache.dictionary["Ruhsane"] == 22)
        XCTAssert(cache.dictionary["Nick"] == 2)
        XCTAssert(cache.dictionary["Brian"] == 222)
    }
}

TestLRUCache.defaultTestSuite.run()
//TestDoublyLinkedList.defaultTestSuite.run()
