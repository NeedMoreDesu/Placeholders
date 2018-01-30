//
//  ArrayAsContents.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 1/30/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

extension Array: TableContents {
    public func sections() -> Int {
        if self[0] is Array {
            return self.count
        } else {
            return 1
        }
    }
    
    public func rows(section: Int) -> Int {
        if self[0] is Array {
            return (self[section] as! Array).count
        } else {
            return self.count
        }
    }
    
    public func generator(path: IndexPath) -> TableViewCellGenerator {
        if self[0] is Array {
            return (self[path.section] as! Array)[path.row] as! TableViewCellGenerator
        } else {
            return self[path.row] as! TableViewCellGenerator
        }
    }
}
