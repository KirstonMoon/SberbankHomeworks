//
//  ViewController.swift
//  Lection 11
//
//  Created by Kirill Magerya on 19.05.2021.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(buttonTapped))
    }
    
    @objc private func buttonTapped() {
        let customActivity = UIActivityViewController(activityItems: [""], applicationActivities: [CustomActivity()])
        customActivity.excludedActivityTypes = [.postToFlickr, .postToVimeo, .saveToCameraRoll]
        
        present(customActivity, animated: true)
    }
}
