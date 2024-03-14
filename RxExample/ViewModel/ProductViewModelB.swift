//
//  ProductViewModelB.swift
//  RxExample
//
//  Created by Samir iOS on 14/03/24.
//

import Foundation
import RxSwift
import RxCocoa

struct ProductViewModelB {
    private var itemsSubject = BehaviorSubject<[Product]>(value: [])
    var items: Observable<[Product]> {
        return itemsSubject.asObservable()
    }
    
    func fetchItems() {
        let products = [
            Product(imageName: "house", title: "Home"),
            Product(imageName: "gear", title: "Settings"),
            Product(imageName: "person.circle", title: "Profile"),
            Product(imageName: "airplane", title: "Flights"),
            Product(imageName: "bell", title: "Activity"),
        ]
        
        itemsSubject.onNext(products)
//        itemsSubject.onCompleted()
    }
    
    func addItems(product: Product) {
        var currentItems = try? itemsSubject.value()
        currentItems = currentItems ?? []
        currentItems?.append(product)
        itemsSubject.onNext(currentItems!)
    }
}
