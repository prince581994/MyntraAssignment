//
//  ProductViewPresenter.swift
//  MyntraAssignment
//
//  Created by PRINCE VERMA on 15/03/21.
//

import Foundation

protocol ProductViewDelegate:NSObjectProtocol {
    
    func productData(_ products: [Products])
}

class ProductViewPresenter {
    
    var apiClient:APIClient?
    
    var productModel = [Products]()
    
    // ProductViewDelegate property
    weak private var delegate:ProductViewDelegate!
    
    init(apiClient:APIClient){
        self.apiClient = apiClient
    }
    
    func setViewDelegate(productViewDelegate:ProductViewDelegate?){
        self.delegate = productViewDelegate
    }
    
    /// public function to get data from ApiClient()
    public func getProductData(){
        apiClient?.getProducts(completion: { (data) in
            self.delegate.productData(data)
        })
    }
}
