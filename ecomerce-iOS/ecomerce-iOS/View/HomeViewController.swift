//
//  HomeViewController.swift
//  ecomerce-iOS
//
//  Created by Yonathan Wijaya on 12/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModelFactory.create()
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        bindingViewModel()
         
    }
    
    func bindingViewModel() {
        viewModel.product
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] _ in
                self?.categoryCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.viewLoad()
        
//        print("@@@ print ", viewModel.product.firstEmit()?.category)
    }
    
    
    private func registerCell() {
        categoryCollectionView
            .register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: nil),
                      forCellWithReuseIdentifier: "CategoryCell")
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCollectionViewCell
        cell?.setupCell(product: viewModel.itemCategory(at: indexPath.row)!)
        cell?.sizeToFit()
        return cell ?? UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCategoryItemCount()
    }
}
