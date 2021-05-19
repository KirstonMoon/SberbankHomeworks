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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                           target: self,
                                                           action: #selector(buttonTapped))
    }
    
    @objc private func buttonTapped() {
        
        let customActivity = CustomActivity()
        let customActivityVC = UIActivityViewController(activityItems: [""], applicationActivities: [customActivity])
        customActivityVC.excludedActivityTypes = [.postToFlickr, .postToVimeo, .saveToCameraRoll]
        
        present(customActivityVC, animated: true)
    }
}
