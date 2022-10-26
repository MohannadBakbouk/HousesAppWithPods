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
    
    private var pictureView : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 8.0
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var gallryCollectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero , collectionViewLayout: collectionViewLayout)
        collection.backgroundColor = .white
        collection.allowsMultipleSelection = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
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
    
    private var galleryLabel : UILabel = {
        let lab = UILabel()
        lab.text = "Gallery"
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        return lab
    }()
    
    private lazy var galleryStack : UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [pictureView , galleryLabel, gallryCollectionView])
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var actorsCollectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero , collectionViewLayout: actorsCollectionViewLayout)
        collection.backgroundColor = .white
        collection.allowsMultipleSelection = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
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
        container.addSubviews(contentOf: [galleryStack , actorsStack , titleStack , armsStack])
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
        gallryCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: String(describing: PhotoCell.self))
        gallryCollectionView.dataSource = self
        gallryCollectionView.delegate = self
        
        actorsCollectionView.register(ActorCell.self, forCellWithReuseIdentifier: String(describing: ActorCell.self))
        actorsCollectionView.dataSource = self
        actorsCollectionView.delegate = self
    }
    
    private func setupTableview(){
        tableView.register(TitleCell.self, forCellReuseIdentifier: String(describing: TitleCell.self))
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupCollectionCellSize(){
        let width = (UIScreen.main.bounds.width) / 5
        collectionViewLayout.itemSize = CGSize(width: width , height: 60)
        
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
        
        galleryStack.snp.makeConstraints{
            $0.top.leading.equalTo(container).offset(10)
            $0.trailing.equalTo(container).offset(-10)
        }
        
        pictureView.snp.makeConstraints { maker in
            maker.width.equalTo(galleryStack.snp.width)
            maker.height.equalTo(200)
        }
        
        gallryCollectionView.snp.makeConstraints { maker in
            maker.height.equalTo(75)
        }
        
        actorsStack.snp.makeConstraints{
            $0.top.equalTo(galleryStack.snp.bottom).offset(10)
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
    }
}

extension HouseDetailsController: SkeletonCollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == gallryCollectionView ? viewModel.gallery.value.count : viewModel.actors.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == gallryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCell.self), for: indexPath) as! PhotoCell
            cell.configure(with: viewModel.gallery.value[indexPath.row])
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ActorCell.self), for: indexPath) as! ActorCell
            cell.configure(with: viewModel.actors.value[indexPath.row])
            cell.layoutIfNeeded()
            return cell
        }
    }
}

extension HouseDetailsController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return  skeletonView == gallryCollectionView ? String(describing: PhotoCell.self) : String(describing: ActorCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = viewModel.gallery.value[indexPath.row]
        pictureView.kf.setImage(with: URL(string: selected.mainUrl)!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == gallryCollectionView {
            let width = (collectionView.frame.width ) / 5
            let hieght = (collectionView.frame.height)
            return CGSize(width: width , height: hieght)
        }
        else {
            let width = (collectionView.frame.width - 10) / 1.7
            let hieght = (collectionView.frame.height - 10 )
            return CGSize(width: width , height: hieght)
        }
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
