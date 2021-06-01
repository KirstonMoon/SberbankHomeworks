//
//  TrackImageViewController.swift
//  Lection 17
//
//  Created by Kirill Magerya on 01.06.2021.
//

import UIKit

class TrackImageViewController: UIViewController {
    
    private let networkService: ItunesNetworkServiceProtocol
    private let imageUrl: String
    
    init(networkService: ItunesNetworkServiceProtocol, trackImage: String) {
        self.networkService = networkService
        self.imageUrl = trackImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let trackImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(trackImageView)
        
        NSLayoutConstraint.activate([
            trackImageView.heightAnchor.constraint(equalToConstant: 100),
            trackImageView.widthAnchor.constraint(equalToConstant: 100),
            trackImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func loadData() {
        networkService.loadImage(fromUrl: imageUrl) { image in
            guard let data = image,
                  let imageFromData = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.trackImageView.image = imageFromData
            }
        }
    }
}
