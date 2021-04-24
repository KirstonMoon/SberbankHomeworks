import Cocoa

class Cat<T> {
    var value: T
    
    init(value: T) {
        self.value = value
    }
}

struct Animal<T> {
    var type: Cat<T>
    var value: T {
        get {
            return type.value
        }
        set {
            if !isKnownUniquelyReferenced(&type) {
                type = Cat(value: newValue)
                return
            }
            type.value = newValue
        }
    }
}
