//
//  TitleCell.swift
//  HousesApp
//
//  Created by Mohannad on 10/25/22.
//
import UIKit
import SnapKit

final class TitleCell: UITableViewCell {
    private var iconView: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: Images.circle))
        img.tintColor = .black
        return img
     }()

    private var contentLabel : UILabel = {
         let lab = UILabel()
         lab.text = "title"
         lab.font = UIFont.boldSystemFont(ofSize: 16)
         lab.textColor = .systemGray
         lab.setContentHuggingPriority(.defaultHigh, for: .horizontal)
         return lab
    }()
    
    private lazy var contentStack : UIStackView =  {
         let stack = UIStackView(arrangedSubviews: [iconView,contentLabel ])
         stack.axis = .horizontal
         stack.spacing = 5
         stack.distribution = .fill
         stack.alignment = .center
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

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        shadowView.dropShadow(color: .systemGray5)
        shadowView.layer.cornerRadius = 8.0
    }
    
    private func setupViews(){
        selectionStyle = .none
        contentView.addSubviews(contentOf: [shadowView , containerView])
        containerView.addSubview(contentStack)
        setupViewsConstraints()
    }
    
    private func setupViewsConstraints(){
        shadowView.snp.makeConstraints{$0.edges.equalTo(contentView)}
        containerView.snp.makeConstraints{
            $0.top.leading.equalTo(contentView).offset(10)
            $0.bottom.trailing.equalTo(contentView).offset(-10)
        }
        contentStack.snp.makeConstraints{$0.edges.equalTo(containerView)}
        iconView.snp.makeConstraints{$0.size.equalTo(20)}
    }
    
    func configure(with value : String){
        contentLabel.text = !value.isEmpty ? value : Messages.noTitle
    }
    
    
}
