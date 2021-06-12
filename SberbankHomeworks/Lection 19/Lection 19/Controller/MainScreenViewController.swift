//
//  ViewController.swift
//  Lection 19
//
//  Created by Kirill Magerya on 08.06.2021.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    private let filter = FilterService()
    private var imagesDataSource = ImagesDataSource()
    private var selectedFilter = String() {
        didSet {
            title = selectedFilter
        }
    }
    
    private var selectedImage = UIImage()
    private var selectedIndex = IndexPath()
    
    private lazy var settingsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(settingsTapped))
        return button
    }()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        return imagePicker
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FilterCell.self, forCellWithReuseIdentifier: FilterCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openPhotoLibrary))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(gestureRecognizer)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(imageView)
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        activateConstraints()
    }
    
    // MARK: - Methods
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Tap to start"
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationItem.rightBarButtonItem = nil
    }
    
    // MARK: - Constraints
    
    private func activateConstraints() {
        NSLayoutConstraint.activate(
            [collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
             collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
             collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
             collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
             imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
             imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
             imageView.bottomAnchor.constraint(equalTo: collectionView.topAnchor)]
        )
    }
    
    // MARK: - Setup button actions
    
    @objc private func settingsTapped() {
        let sliderViewController = SliderViewController()
        sliderViewController.intensity = { [weak self] slider in
            guard let self = self else { return }
            self.imageView.image = self.filter.filterImage(filter: self.selectedFilter,
                                                           image: self.selectedImage,
                                                           intensity: slider)
        }
        present(sliderViewController, animated: true, completion: nil)
    }
    
    @objc private func openPhotoLibrary() {
        present(imagePickerController, animated: true)
    }
}

extension MainScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let pickedImage = info[.editedImage] as? UIImage else { return }
        imageView.image = pickedImage
        selectedImage = pickedImage
        dismiss(animated: true)
        title = "Loading..."
        DispatchQueue.main.async { [self] in
            imagesDataSource.images = filter.filters.map { filter.filterImage(filter: $0,
                                                                              image: pickedImage,
                                                                              intensity: nil) }
            collectionView.reloadData()
            title = "Choose filter"
        }
    }
}


extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}

extension MainScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesDataSource.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.reuseId,
                                                      for: indexPath) as! FilterCell
        cell.configure(filter: filter, image: imagesDataSource, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height / 1.5, height: collectionView.frame.height / 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFilter = filter.filters[indexPath.row]
        selectedIndex = indexPath
        
        DispatchQueue.main.async { [self] in
            let filteredImage = filter.filterImage(filter: filter.filters[indexPath.row],
                                                   image: selectedImage,
                                                   intensity: nil)
            imageView.image = filteredImage
        }
        navigationItem.rightBarButtonItem = settingsButton
    }
}
