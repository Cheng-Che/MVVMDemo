//
//  ViewControllerViewModel.swift
//  MVVMDemo
//
//  Created by Steven Hsieh on 2020/6/5.
//  Copyright © 2020 Steven Hsieh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PhotoControllerViewModel {
    
    private var model:[PhotoModel] = []
    private let disposeBag = DisposeBag()
    private var cellViewModel: [PhotoCellViewModel] = []
    var isloading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)

    init() {
        getImgInfo()
    }
    
    private func getImgInfo() {
        isloading.accept(true)
        do {
            try APIService.shared.getPhoto()?.subscribe(
                onNext: { [weak self] result in
                    self?.model = result
                    self?.isloading.accept(false)
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
                print("onCompleted")
            }).disposed(by: disposeBag)
        } catch let error{
            print(error.localizedDescription)
        }
    }
    
    func getPhotoData() -> [PhotoModel] {
        return model
    }
    
    func getCellData() -> [PhotoCellViewModel] {
        for bas in model{
            let temp = PhotoCellViewModel(title: bas.alt_description, description: bas.description ?? "", imgUrl: bas.urls.regular)
            cellViewModel.append(temp)
        }
        return cellViewModel
    }
    
}
