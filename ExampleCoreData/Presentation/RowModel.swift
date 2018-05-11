//
//  RowModel.swift
//  ExampleCoreData
//
//  Created by Oleksii Horishnii on 5/11/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit

class RowModel {
    enum Alignment {
        case centered
        case left
    }
    let text: String
    let bgColor: UIColor
    let alignment: Alignment
    var clicked: (() -> Void)? = nil
    var deleted: (() -> Void)? = nil
    
    init(text: String,
         bgColor: UIColor,
         alignment: Alignment) {
        self.text = text
        self.bgColor = bgColor
        self.alignment = alignment
    }
    
    static func from(item: Item) -> RowModel {
        return RowModel(text: "id: \(item.id) (\(item.date.toDay()) \(item.date.toTime()))",
            bgColor: UIColor.clear,
            alignment: .left)
    }
    
    static func addItemCell() -> RowModel {
        return RowModel(text: "Add new item",
                        bgColor: UIColor(red: 0.7, green: 1, blue: 0.7, alpha: 1.0),
                        alignment: .centered)
    }
}
