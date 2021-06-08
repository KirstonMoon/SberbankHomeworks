//
//  MainScreenView.swift
//  Lection 19
//
//  Created by Kirill Magerya on 08.06.2021.
//

import UIKit

final class MainScreenView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(imageView)
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI elements
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        return view
    }()
    
    // MARK: - Methods
    
    private func activateConstraints() {
        
        let imageViewConstraints = [imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                                    imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                                    imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                                    imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)]
        
        NSLayoutConstraint.activate(imageViewConstraints)
    }
}
