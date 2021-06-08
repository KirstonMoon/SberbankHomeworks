//
//  ViewController.swift
//  Lection 19
//
//  Created by Kirill Magerya on 08.06.2021.
//

import UIKit

private struct Constants {
    static let navigationBarTitle = "Filter name"
}

final class MainScreenViewController: UIViewController {

    // MARK: - Properties
    
    private let mainScreenView = MainScreenView()
    
    // MARK: - UI elements
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = mainScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }

    // MARK: - Methods
    
    private func setupNavigationBar() {
        title = Constants.navigationBarTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self,
                                                            action: #selector(settingsBarButtonTapped))
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.isTranslucent = false
    }
    
    // MARK: - Setup button actions
    
    @objc private func settingsBarButtonTapped() {
        
    }
}

