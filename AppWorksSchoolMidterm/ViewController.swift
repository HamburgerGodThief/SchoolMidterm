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

    let musicListTableView = CustomTableView()
    let musicProvider = MusicProvider()
    var musicData = [MusicData]()
    var musicSelect = [MusicSelect]()
    var totalCount = 0
    
    func getToken() {
        musicProvider.login(request: MusicRequest.login, completion: { result in
            
            switch result {
                
            case .success(let response):
                
                let token = response.accessToken
                UserDefaults.standard.setValue(token, forKey: "Token")
                
            case .failure:
                
                print("text: 讀取資料失敗！")
            }
        })
    }
    
    func getMusic(index: Int, offset: String) {
        
        guard let token = UserDefaults.standard.string(forKey: "Token") else { return }
        musicProvider.getMusic(request: MusicRequest.playList(requireParameter: PlayList(token: token, offset: offset)), completion: { [weak self] result in
            
            switch result {
                
            case .success(let response):
                
                guard let strongSelf = self else { return }
                if (index == strongSelf.musicSelect.count - 1 && strongSelf.musicSelect.count < strongSelf.totalCount) || strongSelf.musicSelect.count == 0 {
                    
                    strongSelf.musicData = response.data
                    strongSelf.totalCount = response.summary.total
                    let songs = strongSelf.musicData
                    for song in songs {
                        strongSelf.musicSelect.append(MusicSelect(url: song.album.images[1].url,
                                                             songName: song.name,
                                                             selectStatus: false))
                    }
                    print("執行")
                    strongSelf.musicListTableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
                print("text: 讀取資料失敗！")
            }
        })
    }
    
    func musicListTableViewSetting() {
        musicListTableView.delegate = self
        musicListTableView.dataSource = self
        musicListTableView.register(MusicTableViewCell.self, forCellReuseIdentifier: "MusicTableViewCell")
        musicListTableView.separatorStyle = .none
        musicListTableView.contentInsetAdjustmentBehavior = .never
        
        view.addSubview(musicListTableView)
        musicListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            musicListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            musicListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            musicListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            musicListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicListTableViewSetting()
        getToken()
        getMusic(index: 0, offset: "0")
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
        if musicSelect[indexPath.row].selectStatus == false {
            cell.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.favoriteButton.tintColor = .lightGray
        } else {
            cell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.favoriteButton.tintColor = .red
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        getMusic(index: indexPath.row, offset: String(musicSelect.count))
        cell.alpha = 0
        UIView.animate(withDuration: 0.7, delay: 0.02, animations: {
            cell.alpha = 1
        })
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
