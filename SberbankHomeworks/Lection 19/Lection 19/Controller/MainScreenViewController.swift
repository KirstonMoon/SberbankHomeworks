//
//  ViewController.swift
//  Lection 19
//
//  Created by Kirill Magerya on 08.06.2021.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    // MARK: View
    
    private let mainView = MainView()
    
    // MARK: Services
    
    private let filter = FilterService()
    private var imagesDataSource = ImagesDataSource()
    
    // MARK: Properties
    
    private var selectedFilter = String()
    private var selectedImage = UIImage()
    private var selectedIndex = IndexPath()
    
    // MARK: UI
    
    private lazy var saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    private lazy var settingsButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(settingsTapped))
    private lazy var gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openPhotoLibrary))
    
    // MARK: Life cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        mainView.imagePickerController.delegate = self
        setupComponents()
    }
    
    // MARK: Private methods
    
    private func setupComponents() {
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Tap to start"
        navigationController?.navigationBar.barTintColor = .systemBackground
    }
    
    // MARK:  Button actions
    
    @objc private func saveButtonTapped() {
        guard let image = mainView.imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveImage(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func saveImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        
        switch error {
        case .some( _):
            alertController.title = "Some error"
        case .none:
            alertController.title = "Saved"
        }
        
        present(alertController, animated: true)
    }
    
    @objc private func settingsTapped() {
        
        switch mainView.slider.isHidden {
        case true:
            mainView.slider.isHidden = false
        case false:
            mainView.slider.isHidden = true
        }
        
        mainView.intensity = { [weak self] value in
            guard let self = self else { return }
            self.mainView.imageView.image = self.filter.filterImage(filter: self.selectedFilter,
                                                                    image: self.selectedImage,
                                                                    intensity: value)
        }
    }
    
    @objc private func openPhotoLibrary() {
        
        present(mainView.imagePickerController, animated: true)
    }
}

// MARK: - Delegate & DataSource

extension MainScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let pickedImage = info[.editedImage] as? UIImage else { return }
        
        mainView.imageView.image = pickedImage
        selectedImage = pickedImage
        dismiss(animated: true)
        title = "Loading..."
        
        DispatchQueue.main.async { [self] in
            imagesDataSource.images = filter.filters.map { filter.filterImage(filter: $0, image: pickedImage, intensity: nil) }
            mainView.collectionView.reloadData()
            title = "Choose filter"
        }
    }
}


extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        
        return 3
    }
}

extension MainScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        imagesDataSource.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.reuseId, for: indexPath) as! FilterCell
        
        cell.configure(filter: filter, image: imagesDataSource, index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        return CGSize(width: collectionView.frame.height / 1.5, height: collectionView.frame.height / 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        mainView.slider.value = 0.5
        title = String(filter.filters[indexPath.row].dropFirst(2))
        selectedFilter = filter.filters[indexPath.row]
        selectedIndex = indexPath
        
        DispatchQueue.main.async { [self] in
            let filteredImage = filter.filterImage(filter: filter.filters[indexPath.row], image: selectedImage, intensity: nil)
            mainView.imageView.image = filteredImage
        }
        
        navigationItem.rightBarButtonItems = [saveButton, settingsButton]
    }
}
