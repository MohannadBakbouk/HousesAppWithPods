//
//  UIActorView.swift
//  HousesApp
//
//  Created by Mohannad on 10/29/22.
//
import UIKit
import Combine
import SnapKit
import SkeletonView

final class UIActorView: UIStackView {
    
    var cancellables = Set<AnyCancellable>()
    var items: CurrentValueSubject<[ActorViewData]?, Never> = CurrentValueSubject(nil)
    
    private lazy var collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero , collectionViewLayout: collectionViewLayout)
        collection.backgroundColor = .white
        collection.allowsMultipleSelection = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.accessibilityIdentifier = "actorsCollection"
        return collection
    }()
    
    private lazy var collectionViewLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }()
    
    private var titleLabel : UILabel = {
        let lab = UILabel()
        lab.text = "Actors"
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

    private func setupViews() {
       setupStack()
       setupCollectionView()
       setupCollectionCellSize()
       setupViewsConstraints()
       subscripingToItems()
    }
    
    private func setupStack(){
        axis = .vertical
        spacing = 12
        distribution = .fill
        alignment = .fill
        addArrangedSubviews(contentOf: [titleLabel , collectionView])
    }
    
    private func setupCollectionView(){
        collectionView.register(ActorCell.self, forCellWithReuseIdentifier: String(describing: ActorCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isSkeletonable = true
    }
    
    private func setupCollectionCellSize(){
        let actorWidth = (UIScreen.main.bounds.width) / 1.7
        collectionViewLayout.itemSize = CGSize(width: actorWidth , height: 250)
    }
    
    private func setupViewsConstraints(){
        collectionView.snp.makeConstraints { maker in
            maker.height.equalTo(250)
        }
    }
    
    func subscripingToItems(){
        items
       .receive(on: DispatchQueue.main)
       .filter{$0 != nil}
       .sink {[weak self] items in
            guard let items = items , items.count > 0  else {
                self?.collectionView.reloadData()
                self?.collectionView.setMessage(Messages.noResults)
                return
            }
            self?.collectionView.hideMessage()
            self?.collectionView.reloadData()
        }.store(in: &cancellables)
    }
    
    func stopCollectionSkeletonAnimation(){
        collectionView.stopSkeletonAnimation()
        collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
    }

    func startCollectionSkeletonAnimation(){
        collectionView.showAnimatedGradientSkeleton()
    }
}

extension UIActorView: SkeletonCollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ActorCell.self), for: indexPath) as! ActorCell
        cell.configure(with: items.value?[indexPath.row])
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return String(describing: ActorCell.self)
    }
}

extension UIActorView: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 10) / 1.7
        let hieght = (collectionView.frame.height - 10 )
        return CGSize(width: width , height: hieght)
    }
}
