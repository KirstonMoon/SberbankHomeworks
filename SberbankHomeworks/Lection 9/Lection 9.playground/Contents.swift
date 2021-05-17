import UIKit

// MARK: - Builder

struct HouseBuilder {
    private var floors: Int?
    private var color: UIColor?
    
    func createHouse(floors: Int, color: UIColor) -> House {
        return House(numberOfFloors: floors, color: color)
    }
    
}

struct House {
    private(set) var numberOfFloors: Int
    private(set) var color: UIColor
    var about: String {
        return "This house has \(numberOfFloors) floors, and it's color is \(color.accessibilityName)"
    }
}

let houseBuilder = HouseBuilder()
let newHouse = houseBuilder.createHouse(floors: 5, color: .white)
newHouse.about


// MARK: - Abstract Factory

protocol CarProtocol {
    var model: String { get }
    var doors: Int { get }
    var maxSpeed: Int { get }
}

struct Car: CarProtocol {
    private(set) var model: String
    private(set) var doors: Int
    private(set) var maxSpeed: Int
}

protocol CarSetter {
    func setCar() -> CarProtocol
}

struct AudiCar: CarSetter {
    func setCar() -> CarProtocol {
        return Car(model: "A8", doors: 4, maxSpeed: 250)
    }
}

struct ToyotaCar: CarSetter {
    func setCar() -> CarProtocol {
        return Car(model: "Camry", doors: 4, maxSpeed: 170)
    }
}
