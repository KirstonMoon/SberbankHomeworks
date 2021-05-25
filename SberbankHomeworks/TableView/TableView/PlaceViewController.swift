//
//  PlaceViewController.swift
//  TableView
//
//  Created by Kirill Magerya on 25.05.2021.
//

import UIKit

class PlaceViewController: UIViewController {
    
    var recievedPlace: String?
    
    private lazy var visitedPlace: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        visitedPlace.text = recievedPlace
        
        view.addSubview(visitedPlace)
        NSLayoutConstraint.activate([
            visitedPlace.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            visitedPlace.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
