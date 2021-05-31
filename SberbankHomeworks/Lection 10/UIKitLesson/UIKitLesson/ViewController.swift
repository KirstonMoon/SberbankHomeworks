//
//  ViewController.swift
//  UIKitLesson
//
//  Created by Kirill Magerya on 17.05.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    private let donutRadius: CGFloat = 150
    private var holeRadius: CGFloat { return donutRadius / 3 }
    
    private lazy var donutView: DonutView = {
        let donutView = DonutView(donutRadius: donutRadius, holeRadius: holeRadius)
        donutView.translatesAutoresizingMaskIntoConstraints = false
        donutView.backgroundColor = .systemPink
        return donutView
    }()
    
    private lazy var buttonInsideDonut: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = donutView.holeColor
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(buttonInsideDonut)
        view.addSubview(donutView)
        
        activateConstraints()
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            
            donutView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            donutView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            donutView.heightAnchor.constraint(equalToConstant: donutRadius * 2),
            donutView.widthAnchor.constraint(equalToConstant: donutRadius * 2),
            
            buttonInsideDonut.centerXAnchor.constraint(equalTo: donutView.centerXAnchor),
            buttonInsideDonut.centerYAnchor.constraint(equalTo: donutView.centerYAnchor),
            buttonInsideDonut.heightAnchor.constraint(equalToConstant: donutRadius),
            buttonInsideDonut.widthAnchor.constraint(equalToConstant: donutRadius)
        ])
    }
    
    @objc func buttonTapped() {
        present(SecondViewController(), animated: true)
    }
}

