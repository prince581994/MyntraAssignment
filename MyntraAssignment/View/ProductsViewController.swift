//
//  ProductsViewController.swift
//  MyntraAssignment
//
//  Created by PRINCE VERMA on 15/03/21.
//

import UIKit
import Foundation

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var productsTableView: UITableView!
    
    var hiddenSections = Set<Int>()
    
    var productsArray = [Products]()
    
    private let productViewPresenter = ProductViewPresenter(apiClient: APIClient())
    
    //Steps here used before our view initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        preparingUIElements()
    }
    
    // UI elements preparation
    private func preparingUIElements(){
        productViewPresenter.setViewDelegate(productViewDelegate: self)
        productsTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "productCell")
        productViewPresenter.getProductData()
    }
}

//MARK: ProductViewDelegate protocol methods
extension ProductsViewController: ProductViewDelegate{
    
    func productData(_ products: [Products]) {
        
        DispatchQueue.main.async {
            self.productsArray = products
            self.productsTableView.reloadData()
        }
    }
}


//MARK: TableView Dataa Source Methods
extension ProductsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.productsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.hiddenSections.contains(section) {
            return 0
        }
        return self.productsArray[section].sub_category?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let productCell = productsTableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductTableViewCell{
            
            productCell.subCategoryLabel.text = self.productsArray[indexPath.section].sub_category![indexPath.row].display_name
            
            productCell.displayTextLabel.text = self.productsArray[indexPath.section].sub_category![indexPath.row].name
            return productCell
            
        }else{
            return UITableViewCell()
        }
    }
    
    ///Section header information. Views are preferred over title should we decide to provide both
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionButton = RightAlignedIconButton()
        sectionButton.setTitle(String(productsArray[section].name ?? "").uppercased(),
                               for: .normal)
        sectionButton.tag = section
        sectionButton.addTarget(self,
                                action: #selector(self.hideSection(sender:)),
                                for: .touchUpInside)
        
        return sectionButton
    }
    
    
    ///Hide Button Tapped on Table view header
    @objc
    private func hideSection(sender: UIButton) {
        let section = sender.tag
        var indexPaths = [IndexPath]()
        
        func indexPathsForSection() -> [IndexPath] {
            
            for row in 0..<self.productsArray[section].sub_category!.count {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            return indexPaths
        }
        
        if self.hiddenSections.contains(section) {
            UIView.animate(withDuration: 0.5) {
                sender.imageView?.transform = .identity
                
            }
            self.hiddenSections.remove(section)
            self.productsTableView.insertRows(at: indexPathsForSection(),
                                              with: .fade)
        } else {
            UIView.animate(withDuration: 0.5) {
                sender.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }
            self.hiddenSections.insert(section)
            self.productsTableView.deleteRows(at: indexPathsForSection(),
                                              with: .fade)
        }
        
        let indexPathToScroll = IndexPath(row: NSNotFound, section: section)
        self.productsTableView.scrollToRow(at: indexPathToScroll, at: .middle, animated: true)
    }
    
    //Used this for autoresizing the cell height
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}


