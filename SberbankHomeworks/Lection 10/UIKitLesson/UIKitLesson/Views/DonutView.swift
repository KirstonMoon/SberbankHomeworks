//
//  DonutView.swift
//  UIKitLesson
//
//  Created by Kirill Magerya on 17.05.2021.
//

import UIKit

final class DonutView: UIView {

    private var donutRadius: CGFloat = 0.0
    private var holeRadius: CGFloat = 0.0
    private(set) var holeColor = UIColor.clear
    
    private var holeSize: CGRect {
        
        return CGRect(x: bounds.width / 2 - holeRadius, y: bounds.height / 2 - holeRadius,
                      width: holeRadius * 2, height: holeRadius * 2)
    }
    
    convenience init(donutRadius: CGFloat, holeRadius: CGFloat) {
        self.init(frame: CGRect(origin: .zero, size: CGSize(width: donutRadius * 2, height: donutRadius * 2)))
        
        self.donutRadius = donutRadius
        self.holeRadius = holeRadius
        
        layer.cornerRadius = donutRadius
        
        let mutablePath = CGMutablePath()
        let shapeLayer = CAShapeLayer()
        
        mutablePath.addRoundedRect(in: holeSize, cornerWidth: holeRadius, cornerHeight: holeRadius)
        mutablePath.addRect(CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        shapeLayer.backgroundColor = holeColor.cgColor
        shapeLayer.path = mutablePath
        shapeLayer.fillRule = .evenOdd
        
        layer.mask = shapeLayer
        clipsToBounds = true
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        guard isHoleTapped(point: point) else { return nil }
    
        return super.hitTest(point, with: event)
    }
    
    private func isHoleTapped(point: CGPoint) -> Bool {
        
        let path = UIBezierPath(ovalIn: bounds)
        let secondPath = UIBezierPath(ovalIn: holeSize)
        
        guard !secondPath.contains(point), path.contains(point) else { return false }
        
        return true
    }
}
