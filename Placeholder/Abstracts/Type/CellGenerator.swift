//
//  CellGenerator.swift
//  Placeholder
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
    public struct View {
        public var reuseId: String
        public var create: (() -> AnyView)
        public var update: ((AnyView, UIViewController) -> ())
        
        public init<Type>(create: @escaping (() -> Type),
                   update: @escaping ((Type, UIViewController) -> ()),
                   reuseId: String? = nil)
            where Type: AnyView {
                self.create = { () -> AnyView in
                    return create() as AnyView
                }
                self.update = { (anyView: AnyView, vc: UIViewController) -> () in
                    update(anyView as! Type, vc)
                }
                self.reuseId = reuseId ?? String(describing: Type.self)
        }
    }
    
    public struct Xib {
        public var reuseId: String
        public var nib: UINib
        public var update: ((Any, UIViewController) -> ())
        
        public init<Type>(nib: UINib,
                   update: @escaping ((Type, UIViewController) -> ()),
                   reuseId: String? = nil) {
            self.nib = nib
            self.update = { (cell: Any, vc: UIViewController) -> () in
                update(cell as! Type, vc)
            }
            self.reuseId = reuseId ?? String(describing: Type.self)
        }
    }
    
    public struct Static {
        public var reuseId: String = "__staticView"
        public var get: ((UIViewController) -> AnyView)
        
        public init(_ get: @escaping ((UIViewController) -> AnyView)) {
            self.get = get
        }
    }
}
