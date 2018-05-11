//
//  CellGenerator.swift
//  Placeholders
//
//  Created by Oleksii Horishnii on 1/31/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

/*
 Abstract entity, describing how to create and reuse-update view
 */
public struct CellGenerator {
    public enum Creator {
        case generator((() -> AnyView))
        case existingView(AnyView)
        case xib(UINib)
        
        func typeString() -> String {
            switch self {
            case .generator(_):
                return "generator"
            case .existingView(_):
                return "existingView"
            case .xib(_):
                return "xib"
            }
        }
    }

    public var create: Creator
    public var update: ((AnyView, UIViewController) -> Void)?
    public var clicked: (() -> Void)?
    public var deleted: (() -> Void)?
    public var reuseId: String

    public init(create: Creator,
                reuseId: String) {
        self.create = create
        self.reuseId = reuseId
    }

    public init<Type>(create: Creator,
                      update: @escaping ((Type, UIViewController) -> ()),
                      reuseId: String? = nil,
                      clicked: (() -> Void)?,
                      deleted: (() -> Void)?) {
        self.create = create
        self.update =  { (anyView: AnyView, vc: UIViewController) -> () in
            update(anyView as! Type, vc)
        }
        self.reuseId = reuseId ?? create.typeString() + String(describing: Type.self)
        self.clicked = clicked
        self.deleted = deleted
    }
}

extension AnyView {
    public func toCellGenerator() -> CellGenerator {
        return CellGenerator(create: CellGenerator.Creator.existingView(self), reuseId: "__staticView")
    }
}
