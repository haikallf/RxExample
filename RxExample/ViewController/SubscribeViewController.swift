//
//  SubscribeViewController.swift
//  RxExample
//
//  Created by Samir iOS on 14/03/24.
//

import UIKit
import RxSwift
import RxCocoa

// RxSwift with Subscribe

class SubscribeViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = ProductViewModelB()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var addItemButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Add Product", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addProduct), for: .touchUpInside)
        return button
    }()
    
    @objc
    func addProduct() {
        viewModel.addItems(product: Product(imageName: "plus", title: "Addition"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setup()
        bindTableData()
    }
    
    func setup() {
        self.view.addSubview(tableView)
        self.view.addSubview(addItemButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addItemButton.topAnchor, constant: 12),
            
            addItemButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addItemButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addItemButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addItemButton.heightAnchor.constraint(equalToConstant: 44)
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
        
        tableView.rx
            .modelSelected(Product.self)
            .subscribe(onNext: { product in
                print(product.title)
            })
            .disposed(by: disposeBag)
        
        viewModel.fetchItems()
    }
}
