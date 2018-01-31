//
//  TableContentUpdater.swift
//  Tablevc
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
public class TableContents<Type> {
    private var sectionsFn: (() -> Int)
    private var rowsFn: ((_ section: Int) -> Int)
    private var generatorFn: ((_ path: IndexPath) -> Type)
    
    init(sections: @escaping (() -> Int),
         rows: @escaping ((_ section: Int) -> Int),
         generator: @escaping ((_ path: IndexPath) -> Type)) {
        self.sectionsFn = sections
        self.rowsFn = rows
        self.generatorFn = generator
    }

    public func sections() -> Int {
        return self.sectionsFn()
    }
    public func rows(section: Int) -> Int {
        return self.rowsFn(section)
    }
    public func generator(path: IndexPath) -> Type {
        return self.generatorFn(path)
    }
}
