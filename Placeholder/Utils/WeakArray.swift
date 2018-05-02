//
//  WeakArray.swift
//  Placeholder
//
//  Created by Oleksii Horishnii on 3/22/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation

public class WeakItem {
    fileprivate weak var item: AnyObject?
    public func remove() {
        // WeakArray will filter it out on next .items() iteration
        self.item = nil
    }
}

public class WeakArray<Type> {
    private var updateDelegates: [WeakItem] = []
    public func items() -> [Type] {
        let actualItems = self.updateDelegates.filter { (weakItem) -> Bool in
            return weakItem.item != nil
        }
        let unwrappedItems = actualItems.map { $0.item! }
        return unwrappedItems as! [Type]
    }
    public func add(item: Type) -> WeakItem {
        let weakItem = WeakItem()
        weakItem.item = item as AnyObject
        self.updateDelegates.append(weakItem)
        return weakItem
    }
}
