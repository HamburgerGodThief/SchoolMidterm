//
//  ViewController.swift
//  AppWorksSchoolMidterm
//
//  Created by Hamburger on 2020/1/17.
//  Copyright © 2020 Hamburger. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var musicListTableView: UITableView!
    let headerView = TableHeaderView()
    let musicProvider = MusicProvider()
    var musicData = [MusicData]()
    var musicSelect = [MusicSelect]()
    
    func getMusic() {
        musicProvider.getMusic(completion: { [weak self] result in
            
            switch result {
                
            case .success(let response):
                
                self?.musicData = response.data
                guard let songs = self?.musicData else { return }
                for song in songs {
                    self?.musicSelect.append(MusicSelect(url: song.album.images[1].url, songName: song.name, selectStatus: false))
                }
                self?.musicListTableView.reloadData()
                
            case .failure:
                
                print("text: 讀取資料失敗！")
            }
        })
    }
    
    func musicListTableViewSetting() {
        musicListTableView.delegate = self
        musicListTableView.dataSource = self
        musicListTableView.tableHeaderView = headerView
        musicListTableView.register(MusicTableViewCell.self, forCellReuseIdentifier: "MusicTableViewCell")
        musicListTableView.contentInsetAdjustmentBehavior = .never
        musicListTableView.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicListTableViewSetting()
        getMusic()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicSelect.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as? MusicTableViewCell else { return UITableViewCell() }
        let songImageURL = URL(string: musicSelect[indexPath.row].url)
        cell.delegate = self
        cell.songImageView.kf.setImage(with: songImageURL)
        cell.songLable.text = musicSelect[indexPath.row].songName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}

extension ViewController: MusicTableViewCellDelegate {
    
    func songSelect(_ musicTableViewCell: MusicTableViewCell) {
        guard let indexPath = musicListTableView.indexPath(for: musicTableViewCell) else { return }
        if musicSelect[indexPath.row].selectStatus == false {
            musicSelect[indexPath.row].selectStatus = true
            musicTableViewCell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            musicTableViewCell.favoriteButton.tintColor = .red
        } else {
            musicSelect[indexPath.row].selectStatus = false
            musicTableViewCell.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            musicTableViewCell.favoriteButton.tintColor = .lightGray
        }
    }
    
}
