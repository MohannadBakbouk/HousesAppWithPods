//
//  SplashController.swift
//  HousesApp
//
//  Created by Mohannad on 10/29/22.
//
import UIKit
import SnapKit

class SplashController: UIViewController {
    
    weak var coordinator : MainCoordinator?
    
    var inidicatorView:  UIActivityIndicatorView = {
        let item = UIActivityIndicatorView()
        item.tintColor = .darkGray
        item.style = .large
        item.accessibilityIdentifier = "InidicatorView"
        return item
    }()
    
    var slugLabel : UILabel = {
        let lab = UILabel()
        lab.text = "Houses App"
        lab.textColor = .darkGray
        lab.font = UIFont.boldSystemFont(ofSize: 25)
        lab.accessibilityIdentifier = "SlugLabel"
        return lab
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        routeToNextScreen()
    }
    
    func setupUI(){
        view.backgroundColor = .white
        view.addSubviews(contentOf: [slugLabel , inidicatorView])
        setupUIConstrains()
    }
    
    func setupUIConstrains(){
        slugLabel.snp.makeConstraints { maker in
            maker.centerX.equalTo(view.snp.centerX)
            maker.centerY.equalTo(view.snp.centerY).offset(-50)
        }
        
        inidicatorView.snp.makeConstraints { maker in
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            maker.centerX.equalTo(self.view)
        }
    }
    
    func routeToNextScreen()  {
        inidicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.coordinator?.showHouses()
        }
    }
}

