//
//  ProductManager.swift
//  YOOX_NET_PORTER
//
//  Created by Intelivex Labs on 20/06/18.
//  Copyright © 2018 Intelivex Labs. All rights reserved.
//

import Foundation

class ProductManager : NSObject {
    
    func validResponse(json: [String: Any]) -> ([String:Any]?,String?)? {
        if let _ = json["products"] as? [[String:Any]] {
            return (json,nil)
        } else if let error = json["error"] as? String {
            return (nil,error)
        } else {
            return nil
        }
    }

    func GetProductList(data:[String :Any]) -> [Product]? {
        var productList:[Product] = []
        guard let list = data["products"] as? [[String:Any]] else {
            return nil
        }
        
        for dic in list {
            if let product = ToProduct(data: dic) {
                productList.append(product)
            }
        }
        return productList
    }
    
    
    func ToProduct(data:[String :Any]) -> Product? {
        
        guard let productId = data["productId"] as? String ,
            let name = data["title"] as? String ,
            let price = data["price"] as? [String:Any],
            let image = data["image"] as? String,
            let imgURL = ToImageURL(urlString: image) else {
                return nil
        }
        var priceValue = ""
        if let pri = ToPrice(data: price) {
            priceValue = pri.currency
        }
        let product = Product(id: productId,
                              title: name,
                              price: priceValue,
                              imagePath: imgURL)
        return product
    }
    
    func ToImageURL(urlString:String) -> URL? {
        let url = URL(string: URLSchemeFixer.fixMissingScheme(in:urlString))
        return url
    }

    func ToPrice(data:[String :Any]) -> Price? {
        guard let currency = data["now"] as? String,
            let divisor = data["currency"] as? String else {
                return nil
        }
        
        let price = Price(currency: currency, now: divisor)
        return price
    }
}
