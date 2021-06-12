//
//  SliderViewController.swift
//  Lection 19
//
//  Created by Kirill Magerya on 12.06.2021.
//

import UIKit

final class SliderViewController: UIViewController {
    
    var intensity: ((CGFloat) -> ())?
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.setValue(0.5, animated: true)
        slider.addTarget(self, action: #selector(sliderMoved), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(slider)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             slider.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
             slider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)])
    }
    
    @objc func sliderMoved() {
        intensity?(CGFloat(slider.value))
    }
}
