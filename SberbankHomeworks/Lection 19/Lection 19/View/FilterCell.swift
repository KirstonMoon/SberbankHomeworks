//
//  FilterCell.swift
//  Lection 19
//
//  Created by Kirill Magerya on 12.06.2021.
//

import UIKit

final class FilterCell: UICollectionViewCell {
    
    static var reuseId: String {
        self.description()
    }
    
    private lazy var filterView: UIImageView = {
        let filterView = UIImageView()
        filterView.translatesAutoresizingMaskIntoConstraints = false
        return filterView
    }()
    
    private lazy var filterTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(filterView)
        addSubview(filterTitle)
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(filter: FilterService, image: ImagesDataSource, index: Int) {
        self.filterView.image = image.images[index]
        self.filterTitle.text = filter.filters[index]
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate(
            [filterTitle.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
             filterTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
             filterTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
             filterTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
             
             filterView.topAnchor.constraint(equalTo: topAnchor),
             filterView.leadingAnchor.constraint(equalTo: leadingAnchor),
             filterView.trailingAnchor.constraint(equalTo: trailingAnchor),
             filterView.bottomAnchor.constraint(equalTo: filterTitle.topAnchor)])
    }
}
