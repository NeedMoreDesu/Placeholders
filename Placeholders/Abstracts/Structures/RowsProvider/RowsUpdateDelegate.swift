//
//  RowsUpdateDelegate.swift
//  Placeholders
//
//  Created by Oleksii Horishnii on 2/2/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation

/*
 Informs that RowsProvider data was changed
 */
public protocol RowsUpdateDelegate: class {
    func willChangeContent()
    func didChangeContent()
    
    func insert(paths: [IndexPath])
    func delete(paths: [IndexPath])
    func update(paths: [IndexPath])
    
    func sectionInsert(sections: [Int])
    func sectionDelete(sections: [Int])

    func updateUI()
}

/*
 Makes class to conform RowsUpdateDelegate,
 but in fact just translate calls to own delegates
 */
public protocol RowsUpdateDelegateProxy: RowsUpdateDelegate {
    var updateDelegates: WeakArray<RowsUpdateDelegate> { get }
}

extension RowsUpdateDelegateProxy {
    public func willChangeContent() {
        self.updateDelegates.items().forEach { $0.willChangeContent() }
    }
    
    public func didChangeContent() {
        self.updateDelegates.items().forEach { $0.didChangeContent() }
    }
    
    public func insert(paths: [IndexPath]) {
        self.updateDelegates.items().forEach { $0.insert(paths: paths) }
    }
    
    public func delete(paths: [IndexPath]) {
        self.updateDelegates.items().forEach { $0.delete(paths: paths) }
    }
    
    public func update(paths: [IndexPath]) {
        self.updateDelegates.items().forEach { $0.update(paths: paths) }
    }

    public func sectionInsert(sections: [Int]) {
        self.updateDelegates.items().forEach { $0.sectionInsert(sections: sections) }
    }

    public func sectionDelete(sections: [Int]) {
        self.updateDelegates.items().forEach { $0.sectionDelete(sections: sections) }
    }

    public func updateUI() {
        self.updateDelegates.items().forEach { $0.updateUI() }
    }
}
