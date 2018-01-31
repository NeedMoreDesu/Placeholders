//
//  CellGenerator.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 1/31/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

public enum CellGenerator {
    public struct View {
        public var reuseId: String
        var create: (() -> AnyView)
        var update: ((AnyView, UIViewController) -> ())
        
        init<Type>(create: @escaping (() -> Type),
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
        var nib: UINib
        var update: ((Any, UIViewController) -> ())
        
        init<Type>(nib: UINib,
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
        var get: ((UIViewController) -> AnyView)
        
        init(_ get: @escaping ((UIViewController) -> AnyView)) {
            self.get = get
        }
    }
}
