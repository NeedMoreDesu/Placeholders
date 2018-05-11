//
//  Item.swift
//  ExampleCoreData
//
//  Created by Oleksii Horishnii on 5/11/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit

class Item: NSObject {
    let id: Int
    let date: Date
    
    init(id: Int, date: Date) {
        self.id = id
        self.date = date
    }
}
