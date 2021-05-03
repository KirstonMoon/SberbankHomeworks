import UIKit

// MARK: - Задача 2

protocol Container {
    associatedtype Element
    
    var elements: [Element] { get set }
    var count: Int { get }
    mutating func append(element: Element)
    
    subscript(element: Int) -> Element { get }
}

extension Container {
    var count: Int {
        elements.count
    }
    
    mutating func append(element: Element) {
        elements.append(element)
    }
    
    subscript(element: Int) -> Element {
        elements[element]
    }
}

struct Stack<T>: Container {
    typealias Element = T
    
    var elements = [T]()
    
    mutating func pop(element: T) -> T? {
        elements.popLast()
    }
}

struct Queue<T>: Container {
    typealias Element = T
    
    var elements = [T]()
    
    mutating func dequeue() -> T? {
        if elements.isEmpty {
            return nil
        }
        return elements.removeFirst()
    }
}

