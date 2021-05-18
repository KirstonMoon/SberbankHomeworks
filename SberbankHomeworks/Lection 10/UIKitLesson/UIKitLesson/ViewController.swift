//
//  ViewController.swift
//  UIKitLesson
//
//  Created by Kirill Magerya on 17.05.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var donutView: DonutView = {
        let donutView = DonutView(diameter: view.frame.height / 3, color: .systemBlue)
        return donutView
    }()
    
    private lazy var buttonInsideDonut: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(donutView)
        view.addSubview(buttonInsideDonut)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        donutView.center = view.center
        buttonInsideDonut.frame = .init(x: 0, y: 0, width: donutView.frame.width / 3, height: donutView.frame.height / 3)
        buttonInsideDonut.center = view.center
        
        buttonInsideDonut.backgroundColor = .systemBackground
        buttonInsideDonut.layer.cornerRadius = buttonInsideDonut.frame.height / 2
    }
    
    @objc func buttonTapped() {
        present(SecondViewController(), animated: true)
    }
}

