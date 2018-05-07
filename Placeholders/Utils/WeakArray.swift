//
//  WeakArray.swift
//  Placeholders
//
//  Created by Oleksii Horishnii on 3/22/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation

public protocol WeakItem {
    func remove()
    func testIfAlive() -> Bool
    func obtain<Type>() -> Type?
}

public class SimpleWeakItem: WeakItem {
    public weak var item: AnyObject?
    public func remove() {
        // WeakArray will filter it out on next .items() iteration
        self.item = nil
    }
    public func testIfAlive() -> Bool {
        return self.item != nil
    }
    public func obtain<Type>() -> Type? {
        return item as? Type
    }
}

public class WeakArray<Type> {
    private var updateDelegates: [WeakItem] = []
    public func items() -> [Type] {
        let actualItems = self.updateDelegates.filter { (weakItem) -> Bool in
            return weakItem.testIfAlive()
        }
        let unwrappedItems: [Type] = actualItems.compactMap { return $0.obtain() }
        return unwrappedItems
    }
    public func add(item: Type) -> WeakItem {
        let weakItem = SimpleWeakItem()
        weakItem.item = item as AnyObject
        self.updateDelegates.append(weakItem)
        return weakItem
    }
    public func add(weakItem: WeakItem) {
        self.updateDelegates.append(weakItem)
    }
}
