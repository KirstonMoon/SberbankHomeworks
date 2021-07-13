//
//  SwiftFirstLib.swift
//  SwiftFirstLib
//
//  Created by Kirill Magerya on 14.07.2021.
//

import Foundation
import SwiftSecondLib
import ObjcFirstLib

@objc open class SwiftFirstLib: NSObject {
    public let text = "SwiftFirstLib"
    
    @objc public func swiftFirstFunc() -> String {
        text
    }
    
    public func swiftSecondLib() -> String {
        let lib = SwiftSecondLib()
        return lib.text
    }
}
