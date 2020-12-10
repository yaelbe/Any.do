//
//  GroceryCellView.swift
//  Any.do
//
//  Created by Yael Bilu Eran on 09/12/2020.
//

import UIKit
import UIColor_Hex_Swift

class GroceryCellView: UICollectionViewCell {
    
    struct consts {
        static let cornerRadius: CGFloat = 10
    }
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    static let identifier: String = "GroceryCellView"
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Add shadow
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 5.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: consts.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor

        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = consts.cornerRadius
        layer.cornerRadius = consts.cornerRadius
        
        backgroundColor = UIColor.white
    }
    
    func setup( grocery: Grocery) {
        nameLabel.text = grocery.name
        weightLabel.text = grocery.weight
        topView.backgroundColor = UIColor(grocery.bagColor)
    }
}
