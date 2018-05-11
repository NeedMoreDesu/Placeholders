//
//  TableContents+FromArray.swift
//  Placeholders
//
//  Created by Oleksii Horishnii on 1/31/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation

extension RowsProvider {
    public static func from(singleItem: Type) -> RowsProvider {
        return RowsProvider(sections: { () -> Int in
            return 1
        }, rows: { (_) -> Int in
            return 1
        }, item: { _ -> Type in
            return singleItem
        })
    }
    public static func from(array: [Type]) -> RowsProvider {
        return RowsProvider(sections: { () -> Int in
            return 1
        }, rows: { (_) -> Int in
            return array.count
        }, item: { indexPath -> Type in
            return array[indexPath.row]
        })
    }
    public static func from(rows: [[Type]]) -> RowsProvider {
        return RowsProvider(sections: { () -> Int in
            return rows.count
        }, rows: { (section) -> Int in
            return rows[section].count
        }, item: { indexPath -> Type in
            return rows[indexPath.section][indexPath.row]
        })
    }
}
