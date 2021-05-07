//
//  PurchaseService.swift
//  Habitz
//
//  Created by Sam on 2021-05-06.
//

import Foundation
import Purchases

class PurchaseService {
    static func purchase(productID: String?, successfulPurchase: @escaping () -> Void) {
        print("hello")
        guard productID != nil else {
            return
        }
        print("bye")
        //MARK: Perform Purchase
        Purchases.shared.products([productID!]) { products in
            if !products.isEmpty {
                let skProduct = products[0]
                Purchases.shared.purchaseProduct(skProduct) { (transaction, purchaserInfo, error, userCancelled) in
                    if error == nil && !userCancelled {
                        print("LOG: the purchase was successfully made")
                        successfulPurchase()
                    }
                }
            }
        }
    }
}
