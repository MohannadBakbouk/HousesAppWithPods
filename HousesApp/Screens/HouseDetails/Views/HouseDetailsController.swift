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
    
    private var armsLabel : UILabel = {
        let lab = UILabel()
        lab.text = "Coat Of Arms"
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        return lab
    }()
    
    private var armsValueLabel : UILabel = {
        let lab = UILabel()
        lab.text = "arms Label Value"
        lab.numberOfLines = 0
        lab.lineBreakMode = .byWordWrapping
        return lab
    }()
    
    private lazy var armsStack : UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [armsLabel, armsValueLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = .red
        table.showsVerticalScrollIndicator = false
        table.allowsMultipleSelection = false
        table.isScrollEnabled = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 50
        table.separatorStyle = .none
        table.accessibilityIdentifier = "TitlesTableView"
        return table
    }()
    
    private var titleLabel : UILabel = {
        let lab = UILabel()
        lab.text = "Titles"
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        return lab
    }()
    
    private lazy var titleStack : UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [titleLabel, tableView])
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    var tableViewHeight : ConstraintMakerEditable!
    
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
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeight.constraint.update(offset: tableView.contentSize.height)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        container.addSubviews(contentOf: [galleryView, actorsView, titleStack , armsStack])
        setupNavigationBar()
        setupViewsConstraints()
        setupTableview()
    }
    
    private func setupNavigationBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .systemGray
        navigationItem.title = "Details"
    }
    
    
    private func setupTableview(){
        tableView.register(TitleCell.self, forCellReuseIdentifier: String(describing: TitleCell.self))
        tableView.dataSource = self
        tableView.delegate = self
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
        
        titleStack.snp.makeConstraints{
            $0.top.equalTo(actorsView.snp.bottom).offset(10)
            $0.leading.equalTo(container).offset(10)
            $0.trailing.equalTo(container).offset(-10)
        }
        
        tableView.snp.makeConstraints { maker in
            tableViewHeight = maker.height.equalTo(30)
        }
        
        armsStack.snp.makeConstraints{
            $0.top.equalTo(titleStack.snp.bottom).offset(10)
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


extension HouseDetailsController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.details.value.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleCell.self), for: indexPath) as! TitleCell
        cell.configure(with: viewModel.details.value.titles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension HouseDetailsController {
    func bindingDetailsToViews(){
        viewModel.details
        .sink {[weak self] info in
            self?.armsValueLabel.text = info.arms
            self?.galleryView.showMainPicture(with: info.photo)
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
