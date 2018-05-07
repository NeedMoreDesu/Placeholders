//
//  RowsUpdateTranslationMatrix.swift
//  Placeholders
//
//  Created by Oleksii Horishnii on 5/7/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit

class RowsUpdateTranslationMatrix: WeakItem, RowsUpdateDelegate {
    private var target: RowsUpdateDelegate?
    private var sectionShift: Int?
    private var rowShift: ((Int) -> Int)?
    init(target: RowsUpdateDelegate,
         sectionShift: Int?,
         rowShift: ((Int) -> Int)?) {
        self.target = target
        self.sectionShift = sectionShift
        self.rowShift = rowShift
    }
    
    //MARK:- WeakItem
    
    func remove() {
        self.target = nil
    }
    
    func testIfAlive() -> Bool {
        return self.target != nil
    }
    
    func obtain<Type>() -> Type? {
        return self as? Type
    }

    //MARK:- RowsUpdateDelegate
    
    func willChangeContent() {
        self.target?.willChangeContent()
    }
    
    func didChangeContent() {
        self.target?.didChangeContent()
    }
    
    func insert(paths: [IndexPath]) {
        let newPaths = paths.map { (path) -> IndexPath in
            return IndexPath(row: self.rowShift?(path.row) ?? 0 + path.row,
                             section: self.sectionShift ?? 0 + path.section)
        }
        self.target?.insert(paths: newPaths)
    }
    
    func delete(paths: [IndexPath]) {
        let newPaths = paths.map { (path) -> IndexPath in
            return IndexPath(row: self.rowShift?(path.row) ?? 0 + path.row,
                             section: self.sectionShift ?? 0 + path.section)
        }
        self.target?.delete(paths: newPaths)
    }
    
    func update(paths: [IndexPath]) {
        let newPaths = paths.map { (path) -> IndexPath in
            return IndexPath(row: self.rowShift?(path.row) ?? 0 + path.row,
                             section: self.sectionShift ?? 0 + path.section)
        }
        self.target?.update(paths: newPaths)
    }
    
    func updateUI() {
        self.target?.updateUI()
    }
}
