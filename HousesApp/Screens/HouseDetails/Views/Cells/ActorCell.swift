//
//  ActorCell.swift
//  HousesApp
//
//  Created by Mohannad on 10/24/22.
//
import UIKit
import SnapKit

final class ActorCell: BasePhotoCell{
    
    private var nameLabel : UILabel = {
        let lab = UILabel()
        lab.text = "Actor Name"
        lab.font = .boldSystemFont(ofSize: 15)
        lab.textColor = .white
        return lab
    }()
    
    private var bgView: UIView = {
         let view = UIView()
         view.backgroundColor = .red
         view.alpha = 0.5
         return view
    }()
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        bgView.corners(with: [.bottomRight , .topRight], radius: 10)
    }
    
    override func setupViews() {
        contentView.addSubviews(contentOf:[photoView, bgView, nameLabel])
        setupContentView()
        setupViewsConstraints()
    }
    
    override func setupViewsConstraints() {
        super.setupViewsConstraints()
        bgView.snp.makeConstraints { maker in
            maker.leading.equalTo(contentView)
            maker.bottom.equalTo(contentView.snp.bottom).offset(-30)
            maker.height.equalTo(40)
            maker.width.equalTo(contentView).multipliedBy(0.8)
        }
        nameLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(bgView).offset(10)
            maker.top.equalTo(bgView).offset(10)
        }
    }

    func configure(with model : ActorViewData){
        nameLabel.text = model.name
        guard let url = URL(string: model.photo.mainUrl) else { return}
        photoView.kf.setImage(with: url)
    }
}
