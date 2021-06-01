//
//  TrackCell.swift
//  Lection 17
//
//  Created by Kirill Magerya on 01.06.2021.
//

import UIKit

final class TrackCell: UITableViewCell {

    static var cellId: String {
        return self.description()
    }
    
    func configure(with track: Track) {
        textLabel?.text = track.trackName
    }
}
