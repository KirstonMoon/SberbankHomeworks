//
//  MainView.swift
//  Lection 19
//
//  Created by Kirill Magerya on 14.06.2021.
//

import UIKit

final class MainView: UIView {

    var intensity: ((CGFloat) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(imageView)
        addSubview(slider)
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.setValue(0.5, animated: true)
        slider.addTarget(self, action: #selector(sliderMoved), for: .valueChanged)
        slider.isHidden = true

        return slider
    }()
    
    lazy var imagePickerController: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        return imagePicker
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FilterCell.self, forCellWithReuseIdentifier: FilterCell.reuseId)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        
        return collectionView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    override class var requiresConstraintBasedLayout: Bool {
        true
    }
    
    override func updateConstraints() {
        
        NSLayoutConstraint.activate([

            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            slider.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            slider.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            slider.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            slider.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            
            collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
        
        super.updateConstraints()
    }
    
    @objc private func sliderMoved() {
        intensity?(CGFloat(slider.value))
    }
}
