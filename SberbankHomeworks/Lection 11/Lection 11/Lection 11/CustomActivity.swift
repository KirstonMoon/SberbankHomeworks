//
//  CustomActivity.swift
//  Lection 11
//
//  Created by Kirill Magerya on 19.05.2021.
//

import UIKit

final class CustomActivity: UIActivity {

    override class var activityCategory: UIActivity.Category {
        .share
    }
    
    override var activityType: UIActivity.ActivityType? {
        .none
    }
    
    override var activityTitle: String? {
        "Hello"
    }
    
    override var activityImage: UIImage? {
        UIImage(named: "HomerIcon")
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        true
    }
    
    override var activityViewController: UIViewController? {
        let alertController = UIAlertController(title: "Hello, Homer Simpson!", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.activityDidFinish(true)
        }
        alertController.addAction(okAction)
        return alertController
    }
}
