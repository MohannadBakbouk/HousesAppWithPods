//
//  UIInfoView.swift
//  HousesApp
//
//  Created by Mohannad on 10/29/22.
//
import UIKit
import Combine
import SnapKit

final class UIInfoView: UIStackView {
    private var titleLabel : UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        return lab
    }()
    
    private var valueLabel : UILabel = {
        let lab = UILabel()
        lab.text = ""
        lab.numberOfLines = 0
        lab.lineBreakMode = .byWordWrapping
        lab.textColor = .systemGray
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
    }
    
    private func setupStack(){
        axis = .vertical
        spacing = 12
        distribution = .fill
        alignment = .fill
        addArrangedSubviews(contentOf: [titleLabel , valueLabel])
    }
    
    func setInfo(model : TinyInfoViewData){
        titleLabel.text = model.title
        valueLabel.text = model.value
    }
}
