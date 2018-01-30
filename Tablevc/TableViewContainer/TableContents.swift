//
//  TableContentUpdater.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 1/29/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

public struct ViewGenerator {
    var create: (() -> AnyView)
    var update: ((AnyView, UITableView, IndexPath) -> ())
    
    init<Type>(create: @escaping (() -> Type),
               update: @escaping ((Type, UITableView, IndexPath) -> ()))
        where Type: AnyView {
        self.create = { () -> AnyView in
            return create() as AnyView
        }
        self.update = { (anyView: AnyView, tableView: UITableView, indexPath: IndexPath) -> () in
            update(anyView as! Type, tableView, indexPath)
        }
    }
}

public enum TableViewCellGeneratorType {
    case view(viewGenerator: ViewGenerator)
    case staticView(get:((UITableView, IndexPath) -> AnyView))
    case xibCell(nib: UINib, update: ((UITableViewCell, UITableView, IndexPath) -> ()))
}

public struct TableViewCellGenerator {
    let reuseId: String
    let type: TableViewCellGeneratorType
    
    func registerReuseId(tableView: UITableView) {
        switch self.type {
        case .view(_), .staticView(_):
            ContainersTableViewCell.registerReuseId(reuseId: self.reuseId, tableView: tableView)
        case .xibCell(let nib, _):
            tableView.register(nib, forCellReuseIdentifier: reuseId)
        }
    }
    func updateCell(tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath) {
        switch self.type {
        case .view(let generator):
            if let cell = cell as? ContainersTableViewCell {
                if cell.insertedView == nil {
                    cell.tableView = tableView
                    cell.insertedView = generator.create()
                }
                generator.update(cell.insertedView!, tableView, indexPath)
            }
        case .staticView(let get):
            if let cell = cell as? ContainersTableViewCell {
                cell.tableView = tableView
                cell.insertedView = get(tableView, indexPath)
            }
        case .xibCell(_, let update):
            update(cell, tableView, indexPath)
        }
    }
}

public protocol TableContents {
    func sections() -> Int
    func rows(inSection: Int) -> Int
    func generator(path: IndexPath) -> TableViewCellGenerator
}

