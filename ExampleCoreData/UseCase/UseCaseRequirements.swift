//
//  UseCaseRequirements.swift
//  ExampleCoreData
//
//  Created by Oleksii Horishnii on 5/11/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit
import Placeholders

protocol ItemRepository {
    func save(_ item: Item)
    func delete(_ item: Item)
    func allItems() -> RowsProvider<Item>
}
