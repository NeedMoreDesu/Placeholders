//
//  Presenter.swift
//  ExampleCoreData
//
//  Created by Oleksii Horishnii on 5/11/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit
import Placeholders

protocol UseCase {
    var allItems: RowsProvider<Item> { get }
    func addNewItem()
    func deleteItem(item: Item)
}

class PresenterImplementation: NSObject, Presenter {
    var useCase: UseCase
    
    init(useCase: UseCase = Interactor()) {
        self.useCase = useCase
        let itemModels = useCase.allItems.map({ (item) -> RowModel in
            let model = RowModel.from(item: item)
            model.deleted = {
                useCase.deleteItem(item: item)
            }
            return model
        })
        let newItem = RowModel.addItemCell()
        newItem.clicked = {
            useCase.addNewItem()
        }
        let rows = RowsProvider.from(singleItem: newItem) + itemModels
        self.rows = rows
    }
    
    //MARK:- API
    var rows: RowsProvider<RowModel>
}
