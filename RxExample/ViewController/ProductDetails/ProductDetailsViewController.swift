//
//  ProductDetailsViewController.swift
//  RxExample
//
//  Created by Samir iOS on 14/03/24.
//

// MARK: - SUBJECTS AND RELAYS

import UIKit

class ProductDetailsViewController: UIViewController {
    let product: Product
    
    init(product: Product) {
        self.product = product
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
