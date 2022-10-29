//
//  HouseDetailsController.swift
//  HousesApp
//
//  Created by Mohannad on 10/23/22.
//
import UIKit
import Combine
import SnapKit
import SkeletonView
import Kingfisher

class HouseDetailsController: BaseViewController<HouseDetailsViewModel> {
    
    private var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    private var container : UIView = {
        let view = UIView()
        return view
    }()
    
    private var galleryView: UIGalleryView = {
        let galleryView = UIGalleryView()
        return galleryView
    }()
    
    private var actorsView: UIActorView = {
        let actorsView = UIActorView()
        return actorsView
    }()
    
    private var titleView: UITitleView = {
        let titleView = UITitleView()
        return titleView
    }()
    
    private var armsInfoView: UIInfoView = {
        let infoView = UIInfoView()
        return infoView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindingViewsToViewModelEvents()
        viewModel.loadHousePhotos()
        viewModel.loadActors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleView.updateTableHeight()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        container.addSubviews(contentOf: [galleryView, actorsView, titleView , armsInfoView])
        setupNavigationBar()
        setupViewsConstraints()
    }
    
    private func setupNavigationBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .systemGray
        navigationItem.title = "Details"
    }
    
    private func setupViewsConstraints(){
        scrollView.snp.makeConstraints{$0.edges.equalTo(view.safeAreaLayoutGuide)}
        container.snp.makeConstraints{ maker in
            maker.edges.equalTo(scrollView)
            maker.width.equalTo(scrollView).priority(.required)
            maker.height.equalTo(scrollView).priority(.low)
        }
        
        galleryView.snp.makeConstraints{
            $0.top.leading.equalTo(container).offset(10)
            $0.trailing.equalTo(container).offset(-10)
        }
        
        actorsView.snp.makeConstraints{
            $0.top.equalTo(galleryView.snp.bottom).offset(10)
            $0.leading.equalTo(container).offset(10)
            $0.trailing.equalTo(container).offset(-10)
        }
        
        titleView.snp.makeConstraints{
            $0.top.equalTo(actorsView.snp.bottom).offset(10)
            $0.leading.equalTo(container).offset(10)
            $0.trailing.equalTo(container).offset(-10)
        }
        
        armsInfoView.snp.makeConstraints{
            $0.top.equalTo(titleView.snp.bottom).offset(10)
            $0.leading.equalTo(container).offset(10)
            $0.bottom.trailing.equalTo(container).offset(-10)
        }
    }
    private func bindingViewsToViewModelEvents(){
        bindingDetailsToViews()
        bindingGallaryToCollection()
        bindingActorToCollection()
        bindingIsLoadingToAnimator()
    }
}

extension HouseDetailsController {
    func bindingDetailsToViews(){
        viewModel.details
        .sink {[weak self] info in
            self?.armsInfoView.setInfo(model: info.arms)
            self?.galleryView.showMainPicture(with: info.photo)
            self?.titleView.setTitles(with: info.titles)
        }.store(in: &cancellables)
    }
    
    func bindingGallaryToCollection(){
        viewModel.gallery
        .assign(to: \.value, on: galleryView.items)
        .store(in: &cancellables)
    }
    
    func bindingActorToCollection(){
        viewModel.actors
        .assign(to: \.value, on: actorsView.items)
        .store(in: &cancellables)
    }
    
    func bindingIsLoadingToAnimator(){
        viewModel.isLoading
        .receive(on: DispatchQueue.main)
        .sink {[weak self] status in
            _  = status ? self?.actorsView.startCollectionSkeletonAnimation() : self?.actorsView.stopCollectionSkeletonAnimation()
        }.store(in: &cancellables)
    }
}
