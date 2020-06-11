//
//  PhotoCellViewModel.swift
//  MVVMDemo
//
//  Created by Steven Hsieh on 2020/6/4.
//  Copyright © 2020 Steven Hsieh. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class PhotoCellViewModel {
    
    var title: String
    private var description: String
    private var imgUrl: String
    
    private let imgLaodingQueue = OperationQueue()
    var onImageDownloaded: ((UIImage?) -> Void)?

     init(title: String, description: String, imgUrl:String) {
        self.title = title
        self.description = description
        self.imgUrl = imgUrl
    }
    
    func loadImage(){
        guard let url = URL(string: imgUrl) else { return }
        imgLaodingQueue.addOperation { [weak self] in
            guard let self = self else { return }
            do {
                   let data = try Data(contentsOf: url)
                   let image = UIImage(data: data)
                   guard let imageDownloaded = self.onImageDownloaded else { return }
                   imageDownloaded(image)
               } catch let error {
                    print(error.localizedDescription)
               }
        }
    }
    
}
