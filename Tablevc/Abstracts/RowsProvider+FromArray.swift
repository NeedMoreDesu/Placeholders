//
//  TableContents+FromArray.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 1/31/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation

extension RowsProvider {
    class func fromArray(array2d: [[Type]]) -> RowsProvider {
        return RowsProvider(sections: { () -> Int in
            return array2d.count
        }, rows: { (section: Int) -> Int in
            return array2d[section].count
        }) { (indexPath: IndexPath) -> Type in
            return array2d[indexPath.section][indexPath.row]
        }
    }
    class func fromArray(array1d: [Type]) -> RowsProvider {
        return RowsProvider(sections: { () -> Int in
            return 1
        }, rows: { (section: Int) -> Int in
            return array1d.count
        }, generator: { (indexPath: IndexPath) -> Type in
            return array1d[indexPath.row]
        })
    }
}
