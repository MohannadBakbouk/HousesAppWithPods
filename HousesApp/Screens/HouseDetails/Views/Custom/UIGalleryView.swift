//
//  UIGalleryView.swift
//  HousesApp
//
//  Created by Mohannad on 10/29/22.
//
import UIKit
import Combine
import SnapKit
import SkeletonView

final class UIGalleryView: UIStackView {
    
    var cancellables = Set<AnyCancellable>()
    var items: CurrentValueSubject<[PhotoViewData], Never> = CurrentValueSubject([])
    
    private var pictureView : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 8.0
        img.clipsToBounds = true
        img.accessibilityIdentifier = "SelectedGalleryPicture"
        return img
    }()
    
    private var titleLabel : UILabel = {
        let lab = UILabel()
        lab.text = "Gallery"
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        return lab
    }()

    private lazy var collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero , collectionViewLayout: collectionViewLayout)
        collection.backgroundColor = .white
        collection.allowsMultipleSelection = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.accessibilityIdentifier = "GalleryCollection"
        return collection
    }()
    
    private lazy var collectionViewLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
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
       selectFirstCell()
    }
    
    private func setupStack(){
        axis = .vertical
        spacing = 12
        distribution = .fill
        alignment = .fill
        addArrangedSubviews(contentOf: [pictureView, titleLabel , collectionView])
    }
    
    private func setupCollectionView(){
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: String(describing: PhotoCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupCollectionCellSize(){
        let width = (UIScreen.main.bounds.width) / 5
        collectionViewLayout.itemSize = CGSize(width: width , height: 60)
    }
    
    private func setupViewsConstraints(){
        pictureView.snp.makeConstraints { maker in
            maker.width.equalTo(self.snp.width)
            maker.height.equalTo(200)
        }
        
        collectionView.snp.makeConstraints { maker in
            maker.height.equalTo(75)
        }
    }
    
    func showMainPicture(with value : PhotoViewData){
        guard let url = URL(string: value.mainUrl) else {return}
        pictureView.kf.setImage(with: url)
    }
    
    func selectFirstCell(){
        items
       .receive(on: DispatchQueue.main)
       .sink {[weak self] items in
            guard items.count > 0 else {return}
            self?.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
        }.store(in: &cancellables)
    }
}


extension UIGalleryView: SkeletonCollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCell.self), for: indexPath) as! PhotoCell
            cell.configure(with: items.value[indexPath.row])
            return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return String(describing: PhotoCell.self)
    }
}

extension UIGalleryView: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = items.value[indexPath.row]
        pictureView.kf.setImage(with: URL(string: selected.mainUrl)!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width ) / 5
            let hieght = (collectionView.frame.height)
            return CGSize(width: width , height: hieght)
    }
}
