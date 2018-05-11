//
//  UseCase.swift
//  ExampleCoreData
//
//  Created by Oleksii Horishnii on 5/11/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit
import Placeholders

class Interactor: NSObject, UseCase {
    private var itemRepository: ItemRepository
    
    init(forecastRepository: ItemRepository = DatabaseManager.shared) {
        self.itemRepository = forecastRepository
        self.allItems = self.itemRepository.allItems()
    }

    //MARK:- API
    var allItems: RowsProvider<Item>

    func addNewItem() {
        var lastItemId = 0
        if self.allItems.rows(section: 0) > 0 {
            lastItemId = self.allItems[IndexPath(row: 0, section: 0)].id
        }
        let item = Item(id: lastItemId+1, date: Date())
        self.itemRepository.save(item)
    }
    
    func deleteItem(item: Item) {
        self.itemRepository.delete(item)
    }
}
