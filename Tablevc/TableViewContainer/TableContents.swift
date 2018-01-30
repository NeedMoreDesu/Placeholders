//
//  TableContentUpdater.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 1/29/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

public enum TableViewCellGeneratorType {
    public struct View {
        var create: (() -> AnyView)
        var update: ((AnyView, UITableView) -> ())
        
        init<Type>(create: @escaping (() -> Type),
                   update: @escaping ((Type, UITableView) -> ()))
            where Type: AnyView {
                self.create = { () -> AnyView in
                    return create() as AnyView
                }
                self.update = { (anyView: AnyView, tableView: UITableView) -> () in
                    update(anyView as! Type, tableView)
                }
        }
    }
    
    public struct Cell {
        var nib: UINib
        var update: ((UITableViewCell, UITableView) -> ())
        
        init<Type>(nib: UINib,
                   update: @escaping ((Type, UITableView) -> ()))
            where Type: AnyView {
                self.nib = nib
                self.update = { (cell: UITableViewCell, tableView: UITableView) -> () in
                    update(cell as! Type, tableView)
                }
        }
    }
    
    case view(TableViewCellGeneratorType.View)
    case staticView(get:((UITableView) -> AnyView))
    case xibCell(TableViewCellGeneratorType.Cell)
}

public struct TableViewCellGenerator {
    let reuseId: String
    let type: TableViewCellGeneratorType
    
    func registerReuseId(tableView: UITableView) {
        switch self.type {
        case .view(_), .staticView(_):
            ContainersTableViewCell.registerReuseId(reuseId: self.reuseId, tableView: tableView)
        case .xibCell(let generator):
            tableView.register(generator.nib, forCellReuseIdentifier: reuseId)
        }
    }
    func updateCell(tableView: UITableView, cell: UITableViewCell) {
        switch self.type {
        case .view(let generator):
            if let cell = cell as? ContainersTableViewCell {
                if cell.insertedView == nil {
                    cell.tableView = tableView
                    cell.insertedView = generator.create()
                }
                generator.update(cell.insertedView!, tableView)
            }
        case .staticView(let get):
            if let cell = cell as? ContainersTableViewCell {
                cell.tableView = tableView
                cell.insertedView = get(tableView)
            }
        case .xibCell(let generator):
            generator.update(cell, tableView)
        }
    }
}

public protocol TableContents {
    func sections() -> Int
    func rows(inSection: Int) -> Int
    func generator(path: IndexPath) -> TableViewCellGenerator
}

