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
        currentMusicImageView.translatesAutoresizingMaskIntoConstraints = false
        currentMusicImageView.contentMode = .scaleAspectFill
        
        return currentMusicImageView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tableHeaderView?.systemLayoutSizeFitting(CGSize(width: self.frame.size.width, height: self.frame.size.width))
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.tableHeaderView = self.setTableHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
