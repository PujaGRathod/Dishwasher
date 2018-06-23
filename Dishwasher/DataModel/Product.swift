//
//  Product.swift
//  YOOX_NET_PORTER
//
//  Created by Intelivex Labs on 19/06/18.
//  Copyright © 2018 Intelivex Labs. All rights reserved.
//

import Foundation

struct Price {
    var currency : String = ""
    var now : String = ""
}

struct Product: Equatable {
    let id: String
    let title: String
    let price: String
    let imagePath: URL
}

func ==(lhs: Product, rhs: Product) -> Bool {
    return lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.price == rhs.price
        && lhs.imagePath == rhs.imagePath
}
