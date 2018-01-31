//
//  TableContentUpdater.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 1/29/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

public protocol TableContents {
    func sections() -> Int
    func rows(section: Int) -> Int
    func generator(path: IndexPath) -> TableViewCellGenerator
}

