//
//  Grocery.swift
//  Any.do
//
//  Created by Yael Bilu Eran on 09/12/2020.
//

import Foundation
import UIKit

struct Grocery: Codable {
    let name: String
    let bagColor: String
    let weight: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case bagColor = "bagColor"
        case weight = "weight"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        weight = try values.decodeIfPresent(String.self, forKey: .weight) ?? ""
        bagColor = try values.decodeIfPresent(String.self, forKey: .bagColor) ?? ""
//        if let bagColor = try values.decodeIfPresent(String.self, forKey: .bagColor) {
//            if let date = dateFormatter.date(from:creatDate) {
//                creationTime = displayFormat.string(from: date)
//            }
//        }
    }
    
}
