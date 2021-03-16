//
//  ProductTableViewCell.swift
//  MyntraAssignment
//
//  Created by PRINCE VERMA on 15/03/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var displayTextLabel: UILabel!
    @IBOutlet weak var subCategoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
