//
//  ColumnsProvider.swift
//  Placeholders
//
//  Created by Oleksii Horishnii on 2/2/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation

/*
 Provides whole column-related stuff
 */
public class SectionsProvider<Type> {
    private var sectionFn: ((_ section: Int) -> Type?)
    
    public init(section: @escaping ((_ section: Int) -> Type?)) {
        self.sectionFn = section
    }
    
    public func section(section: Int) -> Type? {
        return self.sectionFn(section)
    }
}
