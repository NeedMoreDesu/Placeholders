//
//  TableContentUpdater.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 1/29/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

open protocol TableContents {
    func sections() -> Int
    func rows(inSection: Int) -> Int
    func reuseId(path: IndexPath) -> String
    func updateCell(path: IndexPath, cell: AnyCell)
}

