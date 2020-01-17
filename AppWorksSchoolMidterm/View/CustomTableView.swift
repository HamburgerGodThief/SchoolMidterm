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

class CustomTableView: UITableView {
    
    let currentMusicImageView = UIImageView()
    
    func setTableHeaderView() -> UIView {
        let url = URL(string: "https://i.kfs.io/playlist/global/26541395v266/cropresize/600x600.jpg")
        currentMusicImageView.kf.setImage(with: url)
        addSubview(currentMusicImageView)
        currentMusicImageView.contentMode = .scaleAspectFill
        currentMusicImageView.frame = CGRect(x: 0, y: 0, width: 420, height: 420)

//        currentMusicImageView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            currentMusicImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
//            currentMusicImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
//            currentMusicImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
//            currentMusicImageView.heightAnchor.constraint(equalTo: self.widthAnchor)
//        ])
        
        return currentMusicImageView
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.tableHeaderView = self.setTableHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
