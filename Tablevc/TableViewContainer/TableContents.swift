//
//  TableContentUpdater.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 1/29/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

public struct TableViewCellGenerator {
    var cellType: AnyTableViewCell.Type
    var reuseId: String
    
    func registerReuseId(tableView: UITableView) {
        self.cellType.registerReuseId(reuseId: reuseId, tableView: tableView)
    }
    func reuseCell(cell: UITableViewCell) -> AnyTableViewCell {
        return self.cellType.reuseCell(cell: cell)
    }
}

public protocol TableContents {
    func sections() -> Int
    func rows(inSection: Int) -> Int
    func generator(path: IndexPath) -> TableViewCellGenerator
    func updateCell(path: IndexPath, cell: AnyTableViewCell)
}

