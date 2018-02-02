//
//  TableContents+ToArray.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 1/31/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation

extension RowsProvider {
    /*
     This function is not lazy and generally
     should not be used except for debug purposes
     */
    func toArray() -> [[Type]] {
        var sectionArray: [[Type]] = []
        for section in 0..<self.sections() {
            var rowArray: [Type] = []
            for row in 0..<self.rows(section: section) {
                let element = self.generator(path: IndexPath(row: row, section: section))
                rowArray.append(element)
            }
            sectionArray.append(rowArray)
        }
        return sectionArray
    }
}
