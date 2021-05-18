//
//  SecondViewController.swift
//  UIKitLesson
//
//  Created by Kirill Magerya on 18.05.2021.
//

import UIKit

final class SecondViewController: UIViewController {
    
    private lazy var gradientView: GradientView = {
        let gradient = GradientView(colors: [.systemBlue, .systemPurple])
        return gradient
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(gradientView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientView.frame = view.frame
    }
    
}
