//
//  ProfileViewController.swift
//  MVVMDemo
//
//  Created by Steven Hsieh on 2020/6/11.
//  Copyright © 2020 Steven Hsieh. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var userData = DataPassing.shared.getDataForDetail().user
    private var entryTitle = ["ID", "Total Collections", "Total Likes", "Total Photos"]
    private var entryContent: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        entryContent = [userData.id, "\(userData.total_collections)",  "\(userData.total_likes)", "\(userData.total_photos)"]
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Profile View"
    }
    
    private func viewSetup() {
        profileImg.sd_setImage(with: URL(string: userData.profile_image.medium), completed: nil)
        profileImg.layer.masksToBounds = true
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        nameLabel.text = userData.username
        descriptionLabel.text = userData.bio ?? "No description"
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entryTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        cell.titleLabel.text = entryTitle[indexPath.row]
        cell.contentLabel.text = entryContent[indexPath.row]
        return cell
    }
    
}
