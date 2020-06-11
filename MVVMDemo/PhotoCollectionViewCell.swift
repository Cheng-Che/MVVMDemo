//
//  PhotoCollectionViewCell.swift
//  MVVMDemo
//
//  Created by Steven Hsieh on 2020/6/4.
//  Copyright © 2020 Steven Hsieh. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    private var viewModel: PhotoCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        viewModel?.onImageDownloaded = nil
    }
    
    func setup(viewModel: PhotoCellViewModel){
        self.viewModel = viewModel
        label.text = viewModel.title
        self.viewModel?.onImageDownloaded = { [weak self] img in
            DispatchQueue.main.async {
                self?.imageView.image = img
            }
        }
        self.viewModel?.loadImage()
    }

}
