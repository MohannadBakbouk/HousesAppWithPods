//
//  HouseCell.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import UIKit
import SnapKit
import Kingfisher

final class HouseCell: UICollectionViewCell {
    
    private var photoView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.kf.indicatorType = .activity
        img.layer.masksToBounds = true
        img.isSkeletonable = true
        return img
     }()
    
    private var nameLabel : UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.font = .boldSystemFont(ofSize: 18)
        lab.isSkeletonable = true
        lab.numberOfLines = 0
        return lab
    }()
    
    private var addressLabel : UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.textColor = .systemGray
        lab.isSkeletonable = true
        return lab
    }()
    
    private var addressImageView: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "mappin.and.ellipse"))
        img.tintColor = .systemGray2
        img.isSkeletonable = true
        return img
     }()
    
    private lazy var infoStack : UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [nameLabel, footerStack])
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fill
        stack.isSkeletonable = true
        return stack
    }()
    
    private lazy var footerStack : UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [addressImageView , addressLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.alignment = .center
        stack.isSkeletonable = true
        return stack
    }()
    
    private var shadowView: UIView = {
         let view = UIView()
         view.backgroundColor = .white
         view.isSkeletonable = true
         return view
    }()
    
    private var containerView: UIView = {
         let view = UIView()
         view.backgroundColor = .white
         view.clipsToBounds = true
         view.isSkeletonable = true
         return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.dropShadow(color: .systemGray5)
    }

    func setupViews(){
        isSkeletonable = true
        contentView.isSkeletonable = true
        contentView.addSubview(shadowView)
        contentView.addSubview(containerView)
        containerView.addSubview(photoView)
        containerView.addSubview(infoStack)
        shadowView.dropShadow(color: .systemGray5)
        setupViewsConstraints()
    }
    
    func setupViewsConstraints(){
        containerView.snp.makeConstraints { maker in
            maker.top.leading.equalTo(contentView).offset(10)
            maker.bottom.trailing.equalTo(contentView).offset(-10)
        }
        
        shadowView.snp.makeConstraints { maker in
            maker.edges.equalTo(containerView)
        }
        
        photoView.snp.makeConstraints {  maker in
            maker.top.leading.trailing.equalTo(containerView)
        }
        
        infoStack.snp.makeConstraints {  maker in
            maker.top.equalTo(photoView.snp.bottom).offset(10)
            maker.leading.equalTo(containerView).offset(10)
            maker.bottom.trailing.equalTo(containerView).offset(-10)
        }
        
        addressImageView.snp.makeConstraints {  maker in
            maker.size.equalTo(20)
        }
    }
    
    func configure(with model : HouseViewData){
        nameLabel.text = model.name
        addressLabel.text = model.region
        guard let url = URL(string: model.photoUrl) else { return}
        photoView.kf.setImage(with: url)
    }
}
