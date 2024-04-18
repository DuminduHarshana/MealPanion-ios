//
//  CategoryTableViewCell.swift
//  finalproj2
//
//  Created by Dumindu Harshana on 2024-04-17.
//

import UIKit
import SDWebImage

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    
    func configure(with category: Category) {
        categoryNameLabel.text = category.strCategory
        categoryImageView.sd_setImage(with: URL(string: category.strCategoryThumb), placeholderImage: UIImage(named: "placeholder"))
    }
}
