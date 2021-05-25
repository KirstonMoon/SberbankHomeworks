//
//  CustomTableViewCell.swift
//  TableView
//
//  Created by Kirill Magerya on 25.05.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static var cellId: String {
        return self.description()
    }
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        super.updateConstraints()
    }
    
    @objc private func buttonTapped() {
        
        if contentView.backgroundColor == .green {
            contentView.backgroundColor = .white
        } else {
            contentView.backgroundColor = .green
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        contentView.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
