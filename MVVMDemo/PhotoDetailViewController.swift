//
//  PhotoDetailViewController.swift
//  MVVMDemo
//
//  Created by Steven Hsieh on 2020/6/10.
//  Copyright © 2020 Steven Hsieh. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBAction func userInfoBtn(_ sender: UIButton) {
        let vc: ProfileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: Bundle.main)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private var model: PhotoControllerViewModel!
    private var data: PhotoModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = DataPassing.shared.getDataForDetail()
        viewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Detail View"
    }
    
   private func viewSetup(){
        mainImgView.sd_setImage(with: URL(string: data.urls.regular), completed: nil)
        titleLabel.text = data.alt_description
        titleLabel.adjustsFontSizeToFitWidth = true
        likeLabel.text = "\(data.likes)"
        descriptionLabel.text = "Descrtion: \n" + (data.description ?? "No descrition")
        updateDateLabel.text = "Created at " + changeToDate(date: data.created_at)
        userNameLabel.text = "Author: \(data.user.username)"
    }
    
    private func changeToDate(date: String) -> String{
        return String(date.prefix(10))
    }
    


}
