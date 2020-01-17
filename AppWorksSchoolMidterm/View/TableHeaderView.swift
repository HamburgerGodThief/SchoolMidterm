//
//  TableHeaderView.swift
//  AppWorksSchoolMidterm
//
//  Created by Hamburger on 2020/1/17.
//  Copyright © 2020 Hamburger. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class TableHeaderView: UIView {
    
    let currentMusicImageView = UIImageView()
    
    func setTableHeaderView() {
        let url = URL(string: "https://i.kfs.io/playlist/global/26541395v266/cropresize/600x600.jpg")
        currentMusicImageView.kf.setImage(with: url)
        addSubview(currentMusicImageView)
        currentMusicImageView.translatesAutoresizingMaskIntoConstraints = false
        currentMusicImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            currentMusicImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            currentMusicImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            currentMusicImageView.topAnchor.constraint(equalTo: self.topAnchor),
            currentMusicImageView.heightAnchor.constraint(equalTo: currentMusicImageView.widthAnchor)
        ])
        
    }
    
    override func layoutSubviews() {
        setTableHeaderView()
    }
}
