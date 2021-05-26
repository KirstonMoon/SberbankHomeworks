//
//  ViewController.swift
//  Lection 13
//
//  Created by Kirill Magerya on 26.05.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var animateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var treePicture: UIImageView = {
        let tree = UIImageView()
        tree.translatesAutoresizingMaskIntoConstraints = false
        tree.contentMode = .scaleAspectFit
        tree.image = UIImage(named: "TreePicture")
        tree.isHidden = true
        return tree
    }()
    
    private lazy var appleOne: UIView = {
        let apple = UIView()
        apple.translatesAutoresizingMaskIntoConstraints = false
        apple.isHidden = true
        apple.layer.cornerRadius = 20
        apple.backgroundColor = .systemRed
        return apple
    }()
    
    private lazy var appleTwo: UIView = {
        let apple = UIView()
        apple.translatesAutoresizingMaskIntoConstraints = false
        apple.isHidden = true
        apple.layer.cornerRadius = 20
        apple.backgroundColor = .systemRed
        return apple
    }()
    
    private lazy var appleThree: UIView = {
        let apple = UIView()
        apple.translatesAutoresizingMaskIntoConstraints = false
        apple.isHidden = true
        apple.layer.cornerRadius = 20
        apple.backgroundColor = .systemRed
        return apple
    }()
    
    private lazy var appleFour: UIView = {
        let apple = UIView()
        apple.translatesAutoresizingMaskIntoConstraints = false
        apple.isHidden = true
        apple.layer.cornerRadius = 20
        apple.backgroundColor = .systemRed
        return apple
    }()
    
    private lazy var appleFive: UIView = {
        let apple = UIView()
        apple.translatesAutoresizingMaskIntoConstraints = false
        apple.isHidden = true
        apple.layer.cornerRadius = 20
        apple.backgroundColor = .systemRed
        return apple
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        addingSubviews()
        activateConstraints()
    }
    
    @objc private func buttonTapped() {
        
        treePicture.isHidden = false
        
        treePicture.layer.removeAllAnimations()
        appleOne.layer.removeAllAnimations()
        appleTwo.layer.removeAllAnimations()
        appleThree.layer.removeAllAnimations()
        appleFour.layer.removeAllAnimations()
        appleFive.layer.removeAllAnimations()
        
        treeStartGrowingAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.appleOne.isHidden = false
            self?.appleTwo.isHidden = false
            self?.appleThree.isHidden = false
            self?.appleFour.isHidden = false
            self?.appleFive.isHidden = false
            self?.appleStartOpacityAimation()
        }
    }
}

// MARK: Setup subviews

private extension ViewController {
    
    func addingSubviews() {
        view.addSubview(treePicture)
        view.addSubview(animateButton)
        treePicture.addSubview(appleOne)
        treePicture.addSubview(appleTwo)
        treePicture.addSubview(appleThree)
        treePicture.addSubview(appleFour)
        treePicture.addSubview(appleFive)
    }
}

// MARK: Setup constraints

private extension ViewController {
    
    func activateConstraints() {
        
        NSLayoutConstraint.activate([
            animateButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            animateButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            animateButton.widthAnchor.constraint(equalToConstant: 100),
            animateButton.heightAnchor.constraint(equalToConstant: 50),
            
            treePicture.topAnchor.constraint(equalTo: animateButton.bottomAnchor),
            treePicture.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            treePicture.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            treePicture.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            appleOne.heightAnchor.constraint(equalToConstant: 40),
            appleOne.widthAnchor.constraint(equalToConstant: 40),
            appleOne.centerXAnchor.constraint(equalTo: treePicture.centerXAnchor, constant: 20),
            appleOne.centerYAnchor.constraint(equalTo: treePicture.centerYAnchor, constant: -20),
            
            appleTwo.heightAnchor.constraint(equalToConstant: 40),
            appleTwo.widthAnchor.constraint(equalToConstant: 40),
            appleTwo.centerXAnchor.constraint(equalTo: treePicture.centerXAnchor, constant: 100),
            appleTwo.centerYAnchor.constraint(equalTo: treePicture.centerYAnchor, constant: -50),
            
            appleThree.heightAnchor.constraint(equalToConstant: 40),
            appleThree.widthAnchor.constraint(equalToConstant: 40),
            appleThree.centerXAnchor.constraint(equalTo: treePicture.centerXAnchor, constant: -45),
            appleThree.centerYAnchor.constraint(equalTo: treePicture.centerYAnchor, constant: -90),
            
            appleFour.heightAnchor.constraint(equalToConstant: 40),
            appleFour.widthAnchor.constraint(equalToConstant: 40),
            appleFour.centerXAnchor.constraint(equalTo: treePicture.centerXAnchor, constant: -105),
            appleFour.centerYAnchor.constraint(equalTo: treePicture.centerYAnchor, constant: -65),
            
            appleFive.heightAnchor.constraint(equalToConstant: 40),
            appleFive.widthAnchor.constraint(equalToConstant: 40),
            appleFive.centerXAnchor.constraint(equalTo: treePicture.centerXAnchor, constant: 45),
            appleFive.centerYAnchor.constraint(equalTo: treePicture.centerYAnchor, constant: -120)
        ])
    }
}

// MARK: Setup Tree animations

private extension ViewController {
    
    func treeStartGrowingAnimation() {
        let options: UIView.AnimationOptions = [.curveEaseInOut]
        UIView.animate(withDuration: 4, delay: 0, options: options) { [weak self] in
            guard let self = self else { return }
            self.treePicture.frame.size.height *= 2
        }
    }
}

// MARK: Setup Apple animations

private extension ViewController {
    
    func appleStartOpacityAimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.repeatCount = 1
        
        appleOne.layer.add(animation, forKey: "opacityAppleOne")
        appleTwo.layer.add(animation, forKey: "opacityAppleTwo")
        appleThree.layer.add(animation, forKey: "opacityAppleThree")
        appleFour.layer.add(animation, forKey: "opacityAppleFour")
        appleFive.layer.add(animation, forKey: "opacityAppleFive")
    }
}
