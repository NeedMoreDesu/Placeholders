//
//  ItemRepository.swift
//  ExampleCoreData
//
//  Created by Oleksii Horishnii on 5/11/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit
import PlaceholdersCoreData
import Placeholders
import CoreData

extension DBItem {
    func fromPONSO(_ ponso: Item) {
        self.id = Int32(ponso.id)
        self.date = ponso.date
    }
    func toPONSO() -> Item {
        return Item(id: Int(self.id), date: self.date!)
    }
}

extension DatabaseManager: ItemRepository {
    private func new(_ item: Item) -> DBItem {
        let dbobj = DBItem.init(entity: DBItem.entity(), insertInto: self.managedObjectContext)
        return dbobj
    }
    
    private func find(_ item: Item) -> DBItem? {
        let request = NSFetchRequest<DBItem>(entityName: "Item")
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id = %d", item.id)
        let result = try? self.managedObjectContext.fetch(request)
        return result?.first
    }
    
    public func save(_ item: Item) {
        let dbobj = self.find(item) ?? self.new(item)
        dbobj.fromPONSO(item)
        try? self.managedObjectContext.save()
    }
    
    public func delete(_ item: Item) {
        if let dbobj = self.find(item) {
            self.managedObjectContext.delete(dbobj)
            try? self.managedObjectContext.save()
        }
    }
    
    public func allItems() -> RowsProvider<Item> {
        let dbRows = CoreDataObserver<DBItem>.create(entityName: "Item",
                                             managedObjectContext: self.managedObjectContext,
                                             params: FetchRequestParameters(sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]))
        let itemRows = dbRows.map { $0.toPONSO() }
        return itemRows
    }
}
