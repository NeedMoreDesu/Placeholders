//
//  TableContentUpdater.swift
//  Placeholders
//
//  Created by Oleksii Horishnii on 1/29/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

/*
 Some data grouped into sections and rows;
 Supports lazy initialization;
 */
public class RowsProvider<Type>: RowsUpdateDelegateProxy {
    //MARK:- internals
    private var sectionsFn: (() -> Int)
    private var rowsFn: ((_ section: Int) -> Int)
    private var itemFn: ((_ path: IndexPath) -> Type)

    //MARK:- constructor
    public init(sections: @escaping (() -> Int),
         rows: @escaping ((_ section: Int) -> Int),
         item: @escaping ((_ path: IndexPath) -> Type)) {
        self.sectionsFn = sections
        self.rowsFn = rows
        self.itemFn = item
        self.updateDelegates = WeakArray<RowsUpdateDelegate>()
    }
    
    public func map<NewType>(transform: @escaping (Type) -> NewType) -> RowsProvider<NewType> {
        let retval = RowsProvider<NewType>(sections: self.sectionsFn,
                                           rows: self.rowsFn)
        { (path) -> NewType in
            return transform(self.item(path: path))
        }
        let _ = self.updateDelegates.add(item: retval)
        return retval
    }
    
    public static func combineAddingSections<SameType>(left: RowsProvider<SameType>, right: RowsProvider<SameType>) -> RowsProvider<SameType> {
        let retval = RowsProvider<SameType>(sections: { () -> Int in
            return left.sections() + right.sections()
        }, rows: { (section) -> Int in
            if section < left.sections() {
                return left.rows(section: section)
            } else {
                return right.rows(section: section)
            }
        }, item: { (indexPath: IndexPath) -> SameType in
            if indexPath.section < left.sections() {
                return left.item(path: indexPath)
            } else {
                let path = IndexPath(row: indexPath.row, section: indexPath.section - left.sections())
                return right.item(path: path)
            }
        })
        let _ = left.updateDelegates.add(item: retval)
        let transitionMatrix = RowsUpdateTranslationMatrix(target: retval, sectionShift: left.sections(), rowShift: nil)
        let _ = right.updateDelegates.add(weakItem: transitionMatrix)
        return retval
    }
    
    //MARK:- publics
    
    // use .updateDelegates.add(item: ...) to subscribe for updates
    public var updateDelegates: WeakArray<RowsUpdateDelegate>
    public func sections() -> Int {
        return self.sectionsFn()
    }
    public func rows(section: Int) -> Int {
        return self.rowsFn(section)
    }
    public func item(path: IndexPath) -> Type {
        return self.itemFn(path)
    }
}

public func +<SameType>(left: RowsProvider<SameType>, right: RowsProvider<SameType>) -> RowsProvider<SameType> {
    return RowsProvider<SameType>.combineAddingSections(left: left, right: right) as RowsProvider<SameType>
}
