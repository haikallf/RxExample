//
//  ViewController.swift
//  RxExample
//
//  Created by Samir iOS on 14/03/24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = ProductViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setup()
        bindTableData()
    }
    
    func setup() {
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func bindTableData() {
        viewModel.items.bind(to:
            tableView.rx.items(
                cellIdentifier: "cell",
                cellType: UITableViewCell.self)
        ) { row, item, cell in
            cell.textLabel?.text = item.title
            cell.imageView?.image = UIImage(systemName: item.imageName)
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Product.self).bind { product in
            print(product.title)
        }
        .disposed(by: disposeBag)
        
        viewModel.fetchItems()
    }
}
