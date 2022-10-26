//
//  ViewController.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import Foundation
import UIKit
import SnapKit
import SkeletonView

final class HousesController: BaseViewController<HousesViewModel> {
    let padding : CGFloat = 8.0
    
    lazy var collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero , collectionViewLayout: collectionViewLayout)
        collection.backgroundColor = .white
        collection.allowsMultipleSelection = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    lazy var collectionViewLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindingViewsToViewModelEvents()
        viewModel.loadHouses()
        
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubview(collectionView)
        setupCollection()
        setupViewsConstraints()
        setupCollectionCellSize()
    }
    
    private func bindingViewsToViewModelEvents(){
         bindingHousesToCollectionView()
         bindingIsLoadingToAnimator()
         bindingError()
    }
    
    private func setupCollection(){
        collectionView.register(HouseCell.self, forCellWithReuseIdentifier: String(describing: HouseCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isSkeletonable = true
    }
    
    private func setupCollectionCellSize(){
        let width = (UIScreen.main.bounds.width)
        let hieght = (UIScreen.main.bounds.height) / 3
        collectionViewLayout.itemSize = CGSize(width: width , height: hieght)
    }
    
    private func setupViewsConstraints(){
        collectionView.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
        }
    }
    
    func stopSkeletonAnimation(){
        collectionView.stopSkeletonAnimation()
        collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
        collectionView.reloadData()
    
    }
}

extension HousesController: SkeletonCollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.houses.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HouseCell.self), for: indexPath) as! HouseCell
        cell.configure(with: viewModel.houses.value[indexPath.row])
        return cell
    }
}

extension HousesController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        String(describing: HouseCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = viewModel.houses.value[indexPath.row]
        coordinator?.showHouseDetails(with: selected)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width )
        let hieght = (collectionView.frame.height) / 3
        return CGSize(width: width , height: hieght)
    }
}
