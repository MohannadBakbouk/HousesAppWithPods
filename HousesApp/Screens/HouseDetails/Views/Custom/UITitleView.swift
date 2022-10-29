//
//  UITitleView.swift
//  HousesApp
//
//  Created by Mohannad on 10/29/22.
//
import UIKit
import Combine
import SnapKit
import SkeletonView

final class UITitleView: UIStackView {
    var cancellables = Set<AnyCancellable>()
    var items: CurrentValueSubject<[String], Never> = CurrentValueSubject([])

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
    
    var tableViewHeight : ConstraintMakerEditable!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
       setupStack()
       setupTableview()
       setupViewsConstraints()
       subscripingToItems()
    }
    
    private func setupStack(){
        axis = .vertical
        spacing = 12
        distribution = .fill
        alignment = .fill
        addArrangedSubviews(contentOf: [titleLabel , tableView])
    }
    
    private func setupTableview(){
        tableView.register(TitleCell.self, forCellReuseIdentifier: String(describing: TitleCell.self))
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupViewsConstraints(){
        tableView.snp.makeConstraints { maker in
            tableViewHeight = maker.height.equalTo(30)
        }
    }
    
    func subscripingToItems(){
        items.receive(on: DispatchQueue.main)
       .sink {[weak self] items in
          self?.tableView.reloadData()
        }.store(in: &cancellables)
    }
    
    func setTitles(with values: [String]){
        items.send(values)
    }
    
    func updateTableHeight(){
        tableViewHeight.constraint.update(offset: tableView.contentSize.height)
    }
}


extension UITitleView: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleCell.self), for: indexPath) as! TitleCell
        cell.configure(with: items.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
