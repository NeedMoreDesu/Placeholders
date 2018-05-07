//
//  TableViewCellGenerator.swift
//  Placeholders
//
//  Created by Oleksii Horishnii on 1/31/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

/*
 Adapt all CellGenerators to be able to produce UITableView cells
*/
public protocol TableViewCellGenerator {
    var reuseId: String { get }
    func registerReuseId(tableView: UITableView)
    func updateCell(cell: UITableViewCell, vc: UIViewController)
}

extension CellGenerator: TableViewCellGenerator {
    public func registerReuseId(tableView: UITableView) {
        switch self.create {
        case .existingView(_), .generator(_):
            PlaceholderTableViewCell.registerReuseId(reuseId: self.reuseId, tableView: tableView)
        case .xib(let nib):
            tableView.register(nib, forCellReuseIdentifier: self.reuseId)
        }
    }
    
    public func updateCell(cell: UITableViewCell, vc: UIViewController) {
        switch self.create {
        case .existingView(let view):
            if let cell = cell as? PlaceholderTableViewCell {
                cell.controllingVC = vc
                cell.insertedView = view
                self.update?(cell.insertedView!, vc)
            }
        case .generator(let generator):
            if let cell = cell as? PlaceholderTableViewCell {
                if cell.insertedView == nil {
                    cell.controllingVC = vc
                    cell.insertedView = generator()
                }
                self.update?(cell.insertedView!, vc)
            }
        case .xib(_):
            self.update?(cell, vc)
        }
    }
}
