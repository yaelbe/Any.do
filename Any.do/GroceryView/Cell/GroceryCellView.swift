//
//  GroceryCellView.swift
//  Any.do
//
//  Created by Yael Bilu Eran on 09/12/2020.
//

import UIKit
import UIColor_Hex_Swift

class GroceryCellView: UICollectionViewCell {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    static let identifier: String = "GroceryCellView"
    
    static var nib: UINib {
           return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
    override func awakeFromNib() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 10
    }
    
    func setup( grocery: Grocery) {
        nameLabel.text = grocery.name
        weightLabel.text = grocery.weight
        topView.backgroundColor = UIColor(grocery.bagColor)
    }
}
