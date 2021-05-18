//
//  DonutView.swift
//  UIKitLesson
//
//  Created by Kirill Magerya on 17.05.2021.
//

import UIKit

final class DonutView: UIView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view === self {
            return nil
        }
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(diameter: CGFloat, color: UIColor) {
        self.init(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        backgroundColor = color
        layer.cornerRadius = diameter / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
