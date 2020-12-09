//
//  ViemModel.swift
//  Any.do
//
//  Created by Yael Bilu Eran on 09/12/2020.
//

import Foundation

class ViemModel {
    var data: [Grocery] = []
    
    var onNewData: ((Int) ->())? = nil
    var dataCount: Int {
        return data.count
    }
    
    func startService() {
        DataService.shared.onNewData = { [weak self] grocery in
            guard let self = self else {
                return
            }
            self.data.append(grocery)
            //self.data.insert(grocery, at: 0)
            self.onNewData?(self.data.count - 1)
        }
        
        DataService.shared.startSocket()
    }
    
    func end() {
        DataService.shared.end()
    }
    
    func dataAt(index: Int) -> Grocery {
        return data[index]
    }
}
