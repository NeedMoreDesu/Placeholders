//
//  RowsUpdateDelegate.swift
//  Tablevc
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
    
    func updateUI()
}

/*
 Makes class to conform RowsUpdateDelegate,
 but in fact just translate calls to own delegate
 */
public protocol RowsUpdateDelegateProxy: RowsUpdateDelegate {
    weak var updateDelegate: RowsUpdateDelegate? { get }
}

extension RowsUpdateDelegateProxy {
    public func willChangeContent() {
        self.updateDelegate?.willChangeContent()
    }
    
    public func didChangeContent() {
        self.updateDelegate?.didChangeContent()
    }
    
    public func insert(paths: [IndexPath]) {
        self.updateDelegate?.insert(paths: paths)
    }
    
    public func delete(paths: [IndexPath]) {
        self.updateDelegate?.delete(paths: paths)
    }
    
    public func update(paths: [IndexPath]) {
        self.updateDelegate?.update(paths: paths)
    }
    
    public func updateUI() {
        self.updateDelegate?.updateUI()
    }
}
