import UIKit
import PlaygroundSupport
import XCPlayground
PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: Direct Dispatch

struct DirectDispatch {
    func test() { }
}

let testDirectDispatch = DirectDispatch()
testDirectDispatch.test()

// MARK: Witness Table Dispatch

protocol WitnessTableDispatchProtocol {
    func test()
}

struct WitnessTableDispatchStruct: WitnessTableDispatchProtocol {
    func test() { }
}

class WitnessTableDispatchClass: WitnessTableDispatchProtocol {
    func test() { }
}

let testWitnessTableDispatchStruct: WitnessTableDispatchProtocol = WitnessTableDispatchStruct()
let testWitnessTableDispatchClass = WitnessTableDispatchClass()
testWitnessTableDispatchStruct.test()
testWitnessTableDispatchClass.test()


// MARK: Virtual Table Dispatch

class VirtualTableDispatchClassParent {
    func test() { }
}

class VirtualTableDispatchClassChild: VirtualTableDispatchClassParent {
    override func test() { }
    func testChild() { }
}

let testVirtualTableDispatchClass = VirtualTableDispatchClassChild()
testVirtualTableDispatchClass.test()
testVirtualTableDispatchClass.testChild()

// MARK: Message Dispatch

class MessageDispatchClassParent: NSObject {
    @objc dynamic func test() { }
}

class MessageDispatchClassChild: MessageDispatchClassParent {
    @objc override dynamic func test() { }
}
