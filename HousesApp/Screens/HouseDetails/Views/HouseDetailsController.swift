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
    
    private lazy var actorsCollectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero , collectionViewLayout: actorsCollectionViewLayout)
        collection.backgroundColor = .white
        collection.allowsMultipleSelection = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.accessibilityIdentifier = "actorsCollection"
        return collection
    }()
    
    private lazy var actorsCollectionViewLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }()
    
    private var actorsLabel : UILabel = {
        let lab = UILabel()
        lab.text = "Actors"
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        return lab
    }()
    
    private lazy var actorsStack : UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [actorsLabel, actorsCollectionView])
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
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
        container.addSubviews(contentOf: [galleryView, actorsStack, titleStack , armsStack])
        setupNavigationBar()
        setupViewsConstraints()
        setupCollectionViews()
        setupCollectionCellSize()
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
    
    private func setupCollectionViews(){
        actorsCollectionView.register(ActorCell.self, forCellWithReuseIdentifier: String(describing: ActorCell.self))
        actorsCollectionView.dataSource = self
        actorsCollectionView.delegate = self
        actorsCollectionView.isSkeletonable = true
    }
    
    private func setupTableview(){
        tableView.register(TitleCell.self, forCellReuseIdentifier: String(describing: TitleCell.self))
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupCollectionCellSize(){
        let actorWidth = (UIScreen.main.bounds.width) / 1.7
        actorsCollectionViewLayout.itemSize = CGSize(width: actorWidth , height: 250)
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
        
        actorsStack.snp.makeConstraints{
            $0.top.equalTo(galleryView.snp.bottom).offset(10)
            $0.leading.equalTo(container).offset(10)
            $0.trailing.equalTo(container).offset(-10)
        }
        
        actorsCollectionView.snp.makeConstraints { maker in
            maker.height.equalTo(250)
        }
        
        titleStack.snp.makeConstraints{
            $0.top.equalTo(actorsStack.snp.bottom).offset(10)
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
    
    func stopSkeletonAnimation(){
        actorsCollectionView.stopSkeletonAnimation()
        actorsCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
    }
}

extension HouseDetailsController: SkeletonCollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  (viewModel.actors.value?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ActorCell.self), for: indexPath) as! ActorCell
            cell.configure(with: viewModel.actors.value?[indexPath.row])
            cell.layoutIfNeeded()
            return cell
        
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return   String(describing: ActorCell.self)
    }
    
}

extension HouseDetailsController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width - 10) / 1.7
            let hieght = (collectionView.frame.height - 10 )
            return CGSize(width: width , height: hieght)
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
        .receive(on: DispatchQueue.main)
        .filter{$0 != nil}
        .sink {[weak self] items in
            guard let items = items , items.count > 0  else {
                self?.actorsCollectionView.reloadData()
                self?.actorsCollectionView.setMessage(Messages.noResults)
                return
            }
            self?.actorsCollectionView.hideMessage()
            self?.actorsCollectionView.reloadData()
        }.store(in: &cancellables)
    }
    
    func bindingIsLoadingToAnimator(){
        viewModel.isLoading
        .receive(on: DispatchQueue.main)
        .sink {[weak self] status in
            _  = status ? self?.actorsCollectionView.showAnimatedGradientSkeleton() : self?.stopSkeletonAnimation()
        }.store(in: &cancellables)
    }
}
