//
//  ViewController.swift
//  Lection 13
//
//  Created by Kirill Magerya on 26.05.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var treePicture: UIImageView = {
        let tree = UIImageView()
        tree.contentMode = .scaleAspectFit
        tree.image = UIImage(named: "TreePicture")
        tree.isHidden = true
        return tree
    }()
    
    private lazy var apples: [UIImageView] = {
        var apples = [UIImageView]()
        for _ in 1...20 { apples.append(UIImageView(image: UIImage(named: "ApplePicture"))) }
        
        apples.forEach { apple in
            apple.contentMode = .scaleAspectFit
            apple.isHidden = true
        }
        
        return apples
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(treePicture)
        apples.forEach { view.addSubview($0) }
        
        apples.forEach { $0.frame.size = .init(width: 0, height: 0) }
        apples.forEach { $0.center.x = CGFloat(Int.random(in: Int(view.frame.midX - 100)...Int(view.frame.midX + 100))) }
        apples.forEach { $0.center.y = CGFloat(Int.random(in: Int(view.frame.midY - 130)...Int(view.frame.midY - 10))) }
        
        treePicture.frame.size = .init(width: 0, height: 0)
        treePicture.center.x = view.frame.midX
        treePicture.center.y = view.frame.midY
        
        startAnimation()
    }
    
    private func startAnimation() {
        
        treeGrowingAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.appleAnimation()
        }
    }
    
    private func treeGrowingAnimation() {
        
        treePicture.isHidden = false
        treePicture.layer.removeAllAnimations()
        
        let options: UIView.AnimationOptions = [.curveEaseInOut]
        UIView.animate(withDuration: 3, delay: 0, options: options) {
            [weak self] in
            guard let self = self else { return }
            self.treePicture.bounds.size.height = self.view.frame.height
            self.treePicture.bounds.size.width = self.view.frame.width
        }
    }
    
    private func appleAnimation() {
        
        apples.forEach { $0.layer.removeAllAnimations() }
        
        let options: UIView.AnimationOptions = [.curveEaseInOut]
        let animation = CABasicAnimation(keyPath: "opacity")
        
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 3
        animation.repeatCount = 1
        
        UIView.animate(withDuration: 3, delay: 0, options: options) {
            [weak self] in
            guard let self = self else { return }
            self.apples.forEach { $0.bounds.size.height = 35 }
            self.apples.forEach { $0.bounds.size.width = 35 }
        }
        
        apples.forEach { $0.isHidden = false }
        apples.forEach { $0.layer.add(animation, forKey: "appleOpacity") }
    }
}
