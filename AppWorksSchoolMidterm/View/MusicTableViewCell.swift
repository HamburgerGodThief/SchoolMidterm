//
//  Cell.swift
//  AppWorksSchoolMidterm
//
//  Created by Hamburger on 2020/1/17.
//  Copyright © 2020 Hamburger. All rights reserved.
//

import Foundation
import UIKit

protocol MusicTableViewCellDelegate: AnyObject {
    
    func songSelect(_ musicTableViewCell: MusicTableViewCell)
    
}

class MusicTableViewCell: UITableViewCell {
    
    weak var delegate: MusicTableViewCellDelegate?
    let songImageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    let songLable: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    let favoriteButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.tintColor = .lightGray
        return btn
    }()
    
    @objc func didTouchFavoriteBtn(sender: UIButton) {
        delegate?.songSelect(self)
    }
    
    func setLayout() {
        addSubview(songImageView)
        addSubview(songLable)
        addSubview(favoriteButton)
        songImageView.translatesAutoresizingMaskIntoConstraints = false
        songLable.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            songImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            songImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            songImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            songImageView.heightAnchor.constraint(equalToConstant: 80),
            songImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            songLable.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            songLable.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 20),
            songLable.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -20)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        favoriteButton.addTarget(self, action: #selector(didTouchFavoriteBtn(sender:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
