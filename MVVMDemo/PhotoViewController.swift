//
//  PhotoViewController.swift
//  MVVMDemo
//
//  Created by Steven Hsieh on 2020/6/4.
//  Copyright © 2020 Steven Hsieh. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var PhotoCollectionView: UICollectionView!
    private var viewModel = PhotoControllerViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhotoCollectionView.delegate = self
        PhotoCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 10
        PhotoCollectionView.collectionViewLayout.invalidateLayout()
        PhotoCollectionView.setCollectionViewLayout(layout, animated: false)
        PhotoCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "PhotoCollectionViewCell")

        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Photo View"
    }
    
    func bindViewModel(){
        viewModel.isloading.asObservable().subscribe(onNext:{ [weak self] (value) in
            guard let self = self else { return }
            if value{
                SVProgressHUD.show()
            }else{
                SVProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.PhotoCollectionView.reloadData()
                }
            }
            }).disposed(by: disposeBag)
    }



}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCellData().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(viewModel: viewModel.getCellData()[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DataPassing.shared.setupForDatail(i: indexPath.row, model: viewModel.getPhotoData())
        
        let vc: PhotoDetailViewController = PhotoDetailViewController(nibName: "PhotoDetailViewController", bundle: Bundle.main)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: .zero, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  (screenValue.width - 30) / 2
        return CGSize(width: width, height: width + 30)
    }
    
}
